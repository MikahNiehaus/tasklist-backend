class RoomsController < ApplicationController
    # ✅ POST /rooms --> Create a new room and return the generated room_code
    def create
      room_code = generate_room_code # Generate a random room code
      room = Room.create!(room_code: room_code) # Save the room in DB
  
      render json: { room_code: room.room_code }, status: :created # Return room code
    end
  
    # ✅ GET /rooms/:room_code --> Check if room exists
    def show
      room = Room.find_by(room_code: params[:room_code])
      if room
        render json: { exists: true }
      else
        render json: { exists: false }, status: :not_found
      end
    end
  
    private
  
    # ✅ Generate a Unique 5-Character Room Code (Only Letters & Numbers)
    def generate_room_code
      loop do
        code = (0...5).map { [*'A'..'Z', *'0'..'9'].sample }.join # ✅ Generates a random alphanumeric code
        break code unless Room.exists?(room_code: code) # ✅ Ensure uniqueness
      end
    end
  end
  