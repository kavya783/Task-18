class Doctor < ApplicationRecord
  
  belongs_to :hospital
    has_secure_password
  has_many :patients, dependent: :nullify
  has_many :prescriptions, dependent: :destroy
  has_many :appointments, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :specialization, presence: true
  validates :qualification, presence: true
  validates :city, presence: true
  validates :phone, presence: true
end