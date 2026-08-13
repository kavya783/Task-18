class AddPhoneToDoctors < ActiveRecord::Migration[8.1]
  def change
    add_column :doctors, :phone, :string
  end
end
