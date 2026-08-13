class CreateWelcomes < ActiveRecord::Migration[8.1]
  def change
    create_table :welcomes do |t|
      t.timestamps
    end
  end
end
