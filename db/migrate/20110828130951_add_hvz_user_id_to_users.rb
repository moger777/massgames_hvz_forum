class AddHvzUserIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :hvz_user_id, :integer
  end

  def self.down
    remove_column :users, :hvz_user_id
  end
end
