class AddBelongsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :belongs_to, :user
  end

  def self.down
    remove_column :users, :belongs_to
  end
end
