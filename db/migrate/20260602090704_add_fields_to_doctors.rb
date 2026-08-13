class AddFieldsToDoctors < ActiveRecord::Migration[8.0]
  def change
    add_column :doctors, :name, :string
    add_column :doctors, :qualification, :string
    add_column :doctors, :specialization, :string
    add_column :doctors, :city, :string
  end
end
