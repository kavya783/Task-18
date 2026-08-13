class AddPasswordDigestToHospitals < ActiveRecord::Migration[8.1]
  def change
    add_column :hospitals, :password_digest, :string
  end
end
