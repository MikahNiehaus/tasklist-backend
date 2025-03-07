# db/migrate/20250216213456_create_todos.rb

class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
