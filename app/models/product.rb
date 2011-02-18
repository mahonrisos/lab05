class Product < ActiveRecord::Base
	validate_presence_of :title, :description, :price, :image_url
	validate_numericality_of :price, greater_than_or_equal_to => 0.01
	validate_uniqueness_of :title
	validate_format_of :image_url, :with => %r{\.(gif|jpg|png)$}i
	validate_numericality_of :projection, :only_integer => true, :greater_than => 0
end
