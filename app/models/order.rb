class Order < ActiveRecord::Base
	PAYMENT_TYPES = ["Наличный расчет", "Безналичный расчет"]
	has_many :cart_items, dependent: :destroy
	validates :payment_type, inclusion: PAYMENT_TYPES
	

	def add_cart_items_from_cart(cart)
		cart.cart_items.each do |item|
			item.cart_id = nil
			cart_items << item			
		end		
	end
	
	def total
		cart_items.map do |i| i.total_price end.sum
	end
end
