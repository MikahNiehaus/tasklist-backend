class AddRoomCodeToTodos < ActiveRecord::Migration[8.0]
  def change
    add_column :todos, :room_code, :string
  end
end
