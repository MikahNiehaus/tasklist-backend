class Room < ApplicationRecord
    before_create :generate_unique_room_code
  
    private
  
    # ✅ Generate a Unique 5-Character Room Code
    def generate_unique_room_code
      loop do
        self.room_code = 5.times.map { [*'A'..'Z', *'0'..'9'].sample }.join
        break unless Room.exists?(room_code: room_code)
      end
    end
  end
  