class Address < ActiveRecord::Base
	belongs_to :addressable, polymorphic: true

	validates :name, :address_line1, :city, :state, :zip, :country, presence: true

	def needs_taxed?
		 self.state == "IA" 
	end
end
