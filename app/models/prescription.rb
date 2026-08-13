class Prescription < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :appointment, optional: true

  validates :prescription, presence: true
end
