class Product < ActiveRecord::Base
	belongs_to :inventory

	validate_presence_of			:title,	:description, :price, :image_url
	validate_numericality_of	:price, :greater_than_or_equal_to => 0.01
	validate_uniqueness_of		:title
	validate_format_of				:image_url, :with => %r{\.(gif|jpg|png)$}i
	validate_numericality_of	:projection, :only_integer => true, :greater_than => 0

	before_create :create_inventory_balance
	after_create :complete_inventory_balance_data
	after_update :inventory_balance_update
	before_destroy :eliminate_all_inventory_product_data

	protected

	def create_inventory_balance
		self.amount = 0
		@inventory_item = Inventory.new do |inv_item|
			inv_item.previos_balance = 0
			inv_item.new_balance = self.amount
			inv_item.future_balance = self.amount + self.projection
		end
	end

	def complete_inventory_balance_data
		@inventory_item.product_id = self.id
		@inventory_item.save
	end

	def inventory_balance_update
		last_inv_item = Inventory.where("id = ?", product.id).last
		new_inv_item = Inventory.new do |inv_item|
			inv_item.product_id = self.id
			inv_item.previous_balance = last_inv_item.new_balance
			inv_item.new_balance = self.amount
			inv_item.future_balance = self.amount + self.projection
		end
		new_inv_item.save
	end

	def eliminate_all_inventory_product_data
		Inventory.where("id = ?", product_id).each do |inv_id|
		inv_id.destroy
	end

end
