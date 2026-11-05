class Hospital < ApplicationRecord
  has_secure_password

  # REMOVE THIS:
  # belongs_to :user

  has_one :profile, dependent: :destroy
  has_one_attached :image

  has_many :doctors, dependent: :destroy
  has_many :patients, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :name, :email, :phone, :city, presence: true

  before_create :generate_api_token

  private

  def generate_api_token
    self.api_token = SecureRandom.hex(20)
  end
end