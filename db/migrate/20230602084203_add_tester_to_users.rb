class AddTesterToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tester, :boolean, default: false
  end
end
