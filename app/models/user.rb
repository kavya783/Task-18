  class User < ApplicationRecord
    devise :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable

    has_many :hospitals, dependent: :destroy

  validates :hospital_name, :phone, :city,
          presence: true,
          if: -> { role == "hospital" }

    after_create :create_default_hospital

    def create_default_hospital
      hospitals.create(
        name: hospital_name,
        email: email,
        phone: phone,
        city: city
      )
    end
    
  end   