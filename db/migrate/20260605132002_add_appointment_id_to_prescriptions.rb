class AddAppointmentIdToPrescriptions < ActiveRecord::Migration[8.1]
  def change
    add_column :prescriptions, :appointment_id, :integer
  end
end
