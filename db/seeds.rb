# Check if the todos table exists
unless ActiveRecord::Base.connection.table_exists?(:todos)
    # Manually create the table if it does not exist
    ActiveRecord::Base.connection.create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false
  
      t.timestamps
    end
    puts "Created todos table"
  end
  
  # Only delete if the table exists
  #Todo.delete_all
  
  # Seed some todos
  Todo.create([
    { title: 'Buy groceries', description: 'Get milk, eggs, and bread' },
    { title: 'Complete Rails project', description: 'Work on the tasklist app' }
  ])
  
  puts "Seeded todos"
  