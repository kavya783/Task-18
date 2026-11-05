class User < ApplicationRecord
   devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :hospitals, dependent: :destroy
  has_many :doctors, dependent: :destroy
  validates :hospital_name, :phone, :city, presence: true

  after_create :create_default_hospital
 before_create :generate_api_token

def generate_api_token
  self.api_token = SecureRandom.hex(20)
end
  def create_default_hospital
    hospitals.create(
      name: hospital_name,
      email: email,
      phone: phone,
      city: city
    )
  end
  
end   