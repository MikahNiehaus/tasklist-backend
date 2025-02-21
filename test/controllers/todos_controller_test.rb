require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = Room.create!(room_code: "TESTROOM") # Create a test room
    @table_name = "todos_TESTROOM"

    # Ensure table exists for testing
    ActiveRecord::Base.connection.execute(<<-SQL)
      CREATE TABLE IF NOT EXISTS "#{@table_name}" (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        completed BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    SQL

    # Insert a test todo
    ActiveRecord::Base.connection.execute(<<-SQL)
      INSERT INTO "#{@table_name}" (title, description, completed, created_at, updated_at)
      VALUES ('Test Todo', 'This is a test', FALSE, NOW(), NOW())
    SQL

    @todo_id = ActiveRecord::Base.connection.exec_query("SELECT id FROM \"#{@table_name}\" LIMIT 1").rows.first.first
  end

  test "should get todos index" do
    get "/rooms/TESTROOM/todos"
    assert_response :success
    assert_match "Test Todo", @response.body
  end

  test "should create a new todo" do
    assert_difference -> { ActiveRecord::Base.connection.exec_query("SELECT COUNT(*) FROM \"#{@table_name}\"").rows.first.first }, 1 do
      post "/rooms/TESTROOM/todos", params: { todo: { title: "New Task", description: "New description" } }, as: :json
    end
    assert_response :created
  end

  test "should update a todo" do
    patch "/rooms/TESTROOM/todos/#{@todo_id}", params: { todo: { title: "Updated Task" } }, as: :json
    assert_response :success
    updated_todo = ActiveRecord::Base.connection.exec_query("SELECT title FROM \"#{@table_name}\" WHERE id = #{@todo_id}").rows.first.first
    assert_equal "Updated Task", updated_todo
  end

  test "should delete a todo" do
    assert_difference -> { ActiveRecord::Base.connection.exec_query("SELECT COUNT(*) FROM \"#{@table_name}\"").rows.first.first }, -1 do
      delete "/rooms/TESTROOM/todos/#{@todo_id}"
    end
    assert_response :no_content
  end

  test "should toggle todo completion" do
    patch "/rooms/TESTROOM/todos/#{@todo_id}/toggle"
    assert_response :success
    toggled_status = ActiveRecord::Base.connection.exec_query("SELECT completed FROM \"#{@table_name}\" WHERE id = #{@todo_id}").rows.first.first
    assert_equal true, toggled_status
  end
end
