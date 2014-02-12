class Product < ActiveRecord::Base
	has_many :uploads
	validates :sku, :type, :weight, presence: true
	validates :sku, uniqueness: true
	
	scope :shirts, -> { where(type: 'Shirt') }
	scope :belts, -> { where(type: 'Belt') }
	scope :neckwears, -> { where(type: 'Neckwear') }
	scope :shoes, -> { where(type: 'Shoes') }
	scope :jackets, -> { where(type: 'Jacket') }
	scope :trousers, -> { where(type: 'Trouser') }
	scope :blazers, -> { where(type: 'Blazer') }
	scope :suits, -> { where(type: 'Suit') }
	scope :sweaters, -> { where(type: 'Sweater') }
	scope :overcoats, -> { where(type: 'Overcoat') }

	def types
		["Shirt","Belt","Neckwear","Shoe","Blazer","Suit","Sweater","Overcoat","Jacket","Trouser"]
	end

	def brand_col
		["Brooks Brothers","J.Crew","Jos A. Bank","Forsyth of Canada","Thomas Pink","Turnbull & Asser","Coach","Allen Edmonds","Cole Haan"].sort
	end

	def condition_col
		%w[1 2 3 4 5]
	end
end
