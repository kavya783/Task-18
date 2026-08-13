class AddCityToDoctors < ActiveRecord::Migration[8.1]
  def change
    add_column :doctors, :city, :string
  end
end
