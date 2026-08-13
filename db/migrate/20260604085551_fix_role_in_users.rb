class FixRoleInUsers < ActiveRecord::Migration[8.1]
  def change
       change_column :users, :role, :integer
  end
end
