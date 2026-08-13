class AddLoginFieldsToDoctors < ActiveRecord::Migration[8.1]
  def change
    add_column :doctors, :email, :string
  end
end
