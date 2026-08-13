class AddCityToHospitals < ActiveRecord::Migration[8.1]
  def change
    add_column :hospitals, :city, :string unless column_exists?(:hospitals, :city)
  end
end