class RemoveUserIdFromStore < ActiveRecord::Migration
  def change
    remove_reference :stores, :user, index: true, foreign_key: true
  end
end
