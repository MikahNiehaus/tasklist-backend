class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :room_code, null: false, unique: true  # ✅ Ensures uniqueness
      t.timestamps
    end

    add_index :rooms, :room_code, unique: true  # ✅ Proper way to enforce uniqueness
  end
end
