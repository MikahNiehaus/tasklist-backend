setup do
    # ✅ Create a test room
    @room = Room.create!(room_code: "TEST1")
    @table_name = "todos_TEST1"
  
    # ✅ Ensure the todos table exists
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE TABLE IF NOT EXISTS "#{@table_name}" (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        completed BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    SQL
  
    # ✅ Insert a test todo to avoid "Not Found" errors
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO "#{@table_name}" (title, description, completed, created_at, updated_at)
      VALUES ('Test Todo', 'Test Description', FALSE, NOW(), NOW())
    SQL
  
    # ✅ Fetch the created todo's ID for later tests
    @todo = ActiveRecord::Base.connection.exec_query("SELECT * FROM \"#{@table_name}\" LIMIT 1").to_a.first
  end
  