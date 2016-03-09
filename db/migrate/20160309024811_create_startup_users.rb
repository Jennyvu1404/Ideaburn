class CreateStartupUsers < ActiveRecord::Migration
  def change
    create_table :startup_users do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.integer :founded
      t.integer :bussines_category
      t.string :website
      t.datetime :strength
      t.integer :country
      t.integer :city
      t.text :mission
      t.text :work
      t.integer :register_under
      t.timestamps null: false
    end
  end
end
