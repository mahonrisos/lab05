class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.text :title
      t.text :description
      t.text :image_url
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
