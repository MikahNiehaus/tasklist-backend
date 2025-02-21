class TodosController < ApplicationController
  before_action :set_room
  before_action :ensure_table_exists
  before_action :set_todo, only: %i[update destroy complete]

  # ✅ GET /rooms/:room_code/todos
  def index
    Rails.logger.info "📢 Fetching todos from table: \"#{@table_name}\""

    begin
      todos = ActiveRecord::Base.connection.exec_query("SELECT * FROM \"#{@table_name}\"")
      Rails.logger.info "✅ Todos fetched: #{todos.rows.inspect}"
      render json: todos
    rescue => e
      Rails.logger.error "❌ Error fetching todos: #{e.message}"
      render json: { error: "Error fetching todos" }, status: :internal_server_error
    end
  end

  # ✅ POST /rooms/:room_code/todos (Create Todo)
  def create
    Rails.logger.info "📝 Creating new todo in \"#{@table_name}\" - Raw Params: #{params.inspect}"

    todo_params = params.require(:todo).permit(:title, :description)
    Rails.logger.info "✅ Permitted Params: #{todo_params.inspect}"

    title = todo_params[:title].to_s.strip
    description = todo_params[:description].to_s.strip

    if title.empty?
      Rails.logger.error "❌ ERROR: Title cannot be empty!"
      render json: { error: "Title cannot be empty" }, status: :unprocessable_entity
      return
    end

    sql = <<-SQL
      INSERT INTO "#{@table_name}" (title, description, completed, created_at, updated_at)
      VALUES ('#{title}', '#{description}', FALSE, NOW(), NOW())
      RETURNING id, title, description, completed, created_at, updated_at
    SQL

    begin
      result = ActiveRecord::Base.connection.exec_query(sql)
      created_todo = result.to_a.first
      Rails.logger.info "✅ Todo Created Successfully: #{created_todo.inspect}"
      render json: created_todo, status: :created
    rescue => e
      Rails.logger.error "❌ Error creating todo: #{e.message}"
      render json: { error: "Failed to create todo: #{e.message}" }, status: :unprocessable_entity
    end
  end

# ✅ PATCH /rooms/:room_code/todos/:id (Edit Todo)
def update
  Rails.logger.info "🔄 Updating todo ID #{params[:id]} in \"#{@table_name}\" - Raw Params: #{params.inspect}"

  begin
    # ✅ Ensure parameters are properly permitted
    todo_params = params.require(:todo).permit!
  Rails.logger.info "todo_params #{todo_params}"

    Rails.logger.info "📝 Permitted Params: #{todo_params.inspect}"

   # ✅ Extract title & description correctly, even if they are nested
 extracted_title = nil
 extracted_description = nil

 if todo_params[:title].is_a?(ActionController::Parameters) # If title is nested
  Rails.logger.warn "⚠️ Title is nested inside another object! Extracting..."
  extracted_title = todo_params[:title][:title].to_s.strip
  extracted_description = todo_params[:title][:description].to_s.strip
 else
  extracted_title = todo_params[:title].to_s.strip
  extracted_description = todo_params[:description].to_s.strip
end

Rails.logger.info "📌 Parsed Title: #{extracted_title}"
Rails.logger.info "📌 Parsed Description: #{extracted_description}"


    # ✅ Validate extracted values
    if extracted_title.nil? || extracted_title.strip.empty?
      Rails.logger.error "❌ ERROR: Title cannot be empty!"
      render json: { error: "Title cannot be empty" }, status: :unprocessable_entity
      return
    end

    sql = <<-SQL
      UPDATE "#{@table_name}"
      SET title = '#{ActiveRecord::Base.sanitize_sql(extracted_title)}',
          description = '#{ActiveRecord::Base.sanitize_sql(extracted_description)}',
          updated_at = NOW()
      WHERE id = #{params[:id]}
      RETURNING id, title, description, completed, created_at, updated_at
    SQL

    result = ActiveRecord::Base.connection.exec_query(sql)
    updated_todo = result.to_a.first

    # ✅ Log the updated result
    Rails.logger.info "✅ Todo Updated Successfully: #{updated_todo.inspect}"
    
    render json: updated_todo
  rescue => e
    Rails.logger.error "❌ Error updating todo: #{e.message}"
    render json: { error: "Error updating todo: #{e.message}" }, status: :internal_server_error
  end
end

# ✅ Helper Method: Extract Correct Value (Handles Nested Objects)
def extract_value(value)
  return "" if value.nil? # ✅ Prevents nil errors

  if value.is_a?(Hash) && value[:title] # ✅ Handles deeply nested structure
    return value[:title].to_s.strip
  elsif value.is_a?(String)
    return value.strip
  else
    return value.to_s.strip # ✅ Converts other data types safely
  end
end



  # ✅ DELETE /rooms/:room_code/todos/:id (Delete Todo)
  def destroy
    Rails.logger.info "🗑️ Deleting todo ID #{params[:id]} from \"#{@table_name}\""

    begin
      sql = "DELETE FROM \"#{@table_name}\" WHERE id = #{params[:id]} RETURNING *"
      result = ActiveRecord::Base.connection.exec_query(sql)
      
      if result.to_a.any?
        Rails.logger.info "✅ Todo Deleted: #{result.to_a.first.inspect}"
        head :no_content
      else
        Rails.logger.warn "⚠️ Todo ID #{params[:id]} not found in \"#{@table_name}\""
        render json: { error: "Todo not found" }, status: :not_found
      end
    rescue => e
      Rails.logger.error "❌ Error deleting todo: #{e.message}"
      render json: { error: "Error deleting todo" }, status: :internal_server_error
    end
  end

# ✅ PATCH /rooms/:room_code/todos/:id/toggle
def toggle
  Rails.logger.info "🔄 Toggling todo ID #{params[:id]} in \"#{@table_name}\""

  begin
    # ✅ Ensure ID is valid
    todo_id = params[:id].to_s.strip

    if todo_id.empty?
      Rails.logger.error "❌ ERROR: Todo ID is missing!"
      render json: { error: "Todo ID is required" }, status: :unprocessable_entity
      return
    end

    # ✅ Fetch current todo data
    fetch_sql = "SELECT completed FROM \"#{@table_name}\" WHERE id = #{todo_id}"
    result = ActiveRecord::Base.connection.exec_query(fetch_sql)
    current_todo = result.to_a.first

    if current_todo.nil?
      Rails.logger.error "❌ ERROR: Todo with ID #{todo_id} not found!"
      render json: { error: "Todo not found" }, status: :not_found
      return
    end

    # ✅ Toggle the completed status
    new_status = !current_todo["completed"]
    Rails.logger.info "✅ Current Status: #{current_todo["completed"]} | Toggling to: #{new_status}"

    update_sql = <<-SQL
      UPDATE "#{@table_name}"
      SET completed = #{new_status}, updated_at = NOW()
      WHERE id = #{todo_id}
      RETURNING id, title, description, completed, created_at, updated_at
    SQL

    update_result = ActiveRecord::Base.connection.exec_query(update_sql)
    toggled_todo = update_result.to_a.first

    Rails.logger.info "✅ Todo Toggled Successfully: #{toggled_todo.inspect}"

    render json: toggled_todo
  rescue => e
    Rails.logger.error "❌ Error toggling todo: #{e.message}"
    render json: { error: "Error toggling todo: #{e.message}" }, status: :internal_server_error
  end
end

  private

  # ✅ Ensure Room Exists
  def set_room
    room_code = params[:room_code] || params[:room_room_code]

    if room_code.nil? || room_code.strip.empty?
      Rails.logger.error "❌ ERROR: No room code provided in params! Params: #{params.inspect}"
      render json: { error: "Room code is required" }, status: :bad_request
      return
    end

    room_code = room_code.gsub(/^todos_/, '').upcase
    Rails.logger.info "🔍 Looking for room with code: #{room_code}"

    @room = Room.find_by(room_code: room_code)

    if @room.nil?
      Rails.logger.error "🚨 ERROR: Room not found for code: #{room_code}"
      render json: { error: "Room not found" }, status: :not_found
      return
    end

    @table_name = "todos_#{@room.room_code}"
    Rails.logger.info "✅ Room found: #{@room.room_code} | Table Name: #{@table_name}"
  end

  # ✅ Ensure the Room-Specific Todos Table Exists
  def ensure_table_exists
    @table_name = "todos_#{@room.room_code}"

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS "#{@table_name}" (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        completed BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    SQL

    ActiveRecord::Base.connection.execute(sql)
    Rails.logger.info "✅ Table \"#{@table_name}\" ensured to exist"
  end

  # ✅ Fetch a Todo or Return 404
  def set_todo
    Rails.logger.info "🔍 Looking for todo ID #{params[:id]} in \"#{@table_name}\""

    sql = "SELECT * FROM \"#{@table_name}\" WHERE id = #{params[:id]}"
    
    begin
      result = ActiveRecord::Base.connection.exec_query(sql)
      @todo = result.to_a.first

      if @todo
        Rails.logger.info "✅ Todo Found: #{@todo.inspect}"
      else
        Rails.logger.warn "⚠️ Todo ID #{params[:id]} not found in \"#{@table_name}\""
        render json: { error: "Todo not found" }, status: :not_found
      end
    rescue => e
      Rails.logger.error "❌ Error fetching todo: #{e.message}"
      render json: { error: "Todo not found" }, status: :not_found
    end
  end
end
