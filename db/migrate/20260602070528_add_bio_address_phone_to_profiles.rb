class AddBioAddressPhoneToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :bio, :text
    add_column :profiles, :address, :string
    add_column :profiles, :phone, :string
  end
end
