class AddFieldsToAppointments < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :token_number, :integer
    add_column :appointments, :doctor_notes, :text
  end
end
