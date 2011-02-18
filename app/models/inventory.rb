class Inventory < ActiveRecord::Base
	has_many :products

	validate_numericallity_of :previous_balance
	validate_numericallity_of :new_balance
	validate_numericallity_of :future_balance
end
