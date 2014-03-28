class Type < ActiveRecord::Base
	validates :display_name, presence: true
	#validates :name, uniqueness: true

	def symbolize
		name.underscore.downcase.pluralize.to_sym
	end	

end
