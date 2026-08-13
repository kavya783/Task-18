class AddDetailsToAppointments < ActiveRecord::Migration[8.1]
  def change
    change_table :appointments do |t|
      t.references :hospital, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.string :status
      t.text :reason
    end
  end
end
