class CreateHvzUsers < ActiveRecord::Migration
  def self.up
    create_table :hvz_users do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :hvz_users
  end
end
