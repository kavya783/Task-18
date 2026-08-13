class AddFieldsToPatients < ActiveRecord::Migration[8.1]
  def change
    add_column :patients, :name, :string
    add_column :patients, :age, :integer
    add_column :patients, :disease, :string
    add_column :patients, :phone, :string
  end
end
