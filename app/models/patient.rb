class Patient < ApplicationRecord
  belongs_to :hospital
  belongs_to :doctor, optional: true
  has_many :appointments, dependent: :destroy
  has_many :prescriptions, dependent: :destroy

  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true
  validates :disease, presence: true
  validates :phone, presence: true, uniqueness: true
 
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, confirmation: true, allow_blank: true, on: :update
end
