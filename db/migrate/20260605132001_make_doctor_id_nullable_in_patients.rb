class MakeDoctorIdNullableInPatients < ActiveRecord::Migration[7.0]
  def change
    change_column_null :patients, :doctor_id, true
  end
end