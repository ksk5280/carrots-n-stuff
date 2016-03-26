class AddUserIdToStore < ActiveRecord::Migration
  def change
    add_reference :stores, :user, index: true, foreign_key: true
  end
end
