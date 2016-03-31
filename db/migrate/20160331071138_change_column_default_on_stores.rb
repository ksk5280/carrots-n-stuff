class ChangeColumnDefaultOnStores < ActiveRecord::Migration
  def change
    change_column_default :stores, :image_url, "farmers-market.jpg"
  end
end
