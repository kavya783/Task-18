class CreateHospitals < ActiveRecord::Migration[8.1]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.integer :phone
      t.string :address
      t.string :email
      t.string :city

      t.timestamps
    end
  end
end
