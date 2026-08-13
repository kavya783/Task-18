class AddHospitalToDoctors < ActiveRecord::Migration[8.1]
  def change
    add_reference :doctors, :hospital, null: false, foreign_key: true
  end
end
