require 'test_helper'

class TypeTest < ActiveSupport::TestCase

	test "should not save type without display name" do
		type = Type.new
		assert !type.save, "saved the type without a display name"
	end
	test ""
end
