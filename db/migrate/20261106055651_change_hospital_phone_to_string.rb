class ChangeHospitalPhoneToString < ActiveRecord::Migration[8.1]
  def change
    change_column :hospitals, :phone, :string
  end
end