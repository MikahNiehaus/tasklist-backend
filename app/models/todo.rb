class Todo < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :description, length: { maximum: 1000 }, allow_blank: true
    validates :completed, inclusion: { in: [true, false] }
  end
  