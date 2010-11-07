class AddHasManyUser < ActiveRecord::Migration
  def self.up
    create_table :users_links do |t|
      t.belongs_to :user
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :users_links
  end
end
