class AddHospitalToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_reference :profiles, :hospital, null: false, foreign_key: true
  end
end
