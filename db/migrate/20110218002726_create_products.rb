class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.text :title, :null => false
      t.text :description, :null => false
      t.text :image_url, :null => false
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :projection
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
