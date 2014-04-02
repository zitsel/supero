class BrandList < ActiveRecord::Base
	validates_uniqueness_of :name
	def self.list
		self.all.pluck(:name).sort
	end
end
