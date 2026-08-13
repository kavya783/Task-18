class Appointment < ApplicationRecord
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :patient


  has_many :prescriptions
  validates :hospital, presence: true
  validates :doctor, presence: true
  validates :patient, presence: true
  validates :scheduled_at, presence: true
end
