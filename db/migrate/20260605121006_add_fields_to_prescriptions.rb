class AddFieldsToPrescriptions < ActiveRecord::Migration[8.1]
  def change
    add_reference :prescriptions, :patient, null: false, foreign_key: true
    add_column :prescriptions, :prescription, :text
  end
end
