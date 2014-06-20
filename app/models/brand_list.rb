class BrandList < ActiveRecord::Base
	validates_uniqueness_of :name
	validates :name, presence: true

	def self.list
		self.all.pluck(:name).sort
	end
end
