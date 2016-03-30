class AddDroneToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :drone, :integer
  end
end
