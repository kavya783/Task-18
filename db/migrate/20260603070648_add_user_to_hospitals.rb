class AddUserToHospitals < ActiveRecord::Migration[8.1]
  def change
add_reference :hospitals, :user, foreign_key: true
  end
end
