class AddAppointmentTypeToAppointments < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :appointment_type, :string
  end
end
