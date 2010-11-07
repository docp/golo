class CreateUserLinks < ActiveRecord::Migration
  def self.up
    create_table :user_links do |t|
      t.integer :parent_user_id
      t.integer :child_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_links
  end
end
