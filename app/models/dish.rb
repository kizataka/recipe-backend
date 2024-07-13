class Dish < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { maximum: 20 }
    validates :description, presence: true
    # validates :image, presence: true
end
