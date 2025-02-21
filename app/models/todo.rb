class Todo < ApplicationRecord
    belongs_to :room, foreign_key: :room_code, primary_key: :room_code
  
    validates :title, presence: true, length: { maximum: 255 }
    validates :description, length: { maximum: 1000 }, allow_blank: true
    validates :completed, inclusion: { in: [true, false] }
    validates :room_code, presence: true
  end
  