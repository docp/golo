class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :forename
      t.string :surname
      t.string :email
      t.string :street
      t.integer :zipcode
      t.string :town
      t.string :state
      t.string :country
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
