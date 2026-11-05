class AddApiTokenToHospitals < ActiveRecord::Migration[8.1]
  def change
    add_column :hospitals, :api_token, :string
    add_index :hospitals, :api_token, unique: true
  end
end