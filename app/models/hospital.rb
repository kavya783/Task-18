class Hospital < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy
  has_one_attached :image
  belongs_to :user
  has_many :doctors, dependent: :destroy
  has_many :patients, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :city, presence: true
end