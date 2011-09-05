class AddCreatureTypeToForum < ActiveRecord::Migration
  def self.up
    add_column :forums, :creature_type, :string, :default => 'all'
  end

  def self.down
    remove_column :forums, :creature_type
  end
end
