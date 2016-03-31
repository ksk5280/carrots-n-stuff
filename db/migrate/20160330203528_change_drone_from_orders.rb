class ChangeDroneFromOrders < ActiveRecord::Migration
  def change
    change_column :orders, :drone, :integer, :default => 0
  end
end
