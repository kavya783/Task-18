class AddDefaultStatusToAppointments < ActiveRecord::Migration[8.1]
  def change
  change_column_default :appointments, :status, "Pending"
end
end
