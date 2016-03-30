class RemoveStoreIdFromUser < ActiveRecord::Migration
  def change
    remove_foreign_key :users, :store
  end
end
