class AddDoctorIdToPrescriptions < ActiveRecord::Migration[8.1]
  def change
    add_reference :prescriptions, :doctor, null: false, foreign_key: true
  end
end
