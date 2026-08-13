class CreatePrescriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :prescriptions do |t|
      t.timestamps
    end
  end
end
