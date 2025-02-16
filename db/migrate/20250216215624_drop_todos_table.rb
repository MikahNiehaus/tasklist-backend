# db/migrate/20250216213324_drop_todos_table.rb

class DropTodosTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :todos, if_exists: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
