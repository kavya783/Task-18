class Profile < ApplicationRecord
    belongs_to:hospital
    validates :bio, presence: true
  validates :address, presence: true
  validates :phone, presence: true
end
