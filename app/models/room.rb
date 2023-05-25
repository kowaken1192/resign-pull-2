class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  has_many :reservations
  validates :name , presence: true 
  validates :address , presence: true
  validates :price , presence: true , numericality: { greater_than_or_equal_to: 0 }
  validates :introduction, presence: true 

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "introduction", "name", "price", "room_image", "updated_at", "user_id","room_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["reservations", "user"]
  end

  def self.search(area, keyword)
    rooms = Room.all

    if area.present?
      rooms = rooms.where("address LIKE ?", "%#{area}%")
    end

    if keyword.present?
      rooms = rooms.where("name LIKE ?", "%#{keyword}%")
    end

    rooms
  end
end
