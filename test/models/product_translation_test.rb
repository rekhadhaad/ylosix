require 'test_helper'

class ProductTranslationTest < ActiveSupport::TestCase
    test 'should have unique slug' do
    	slug1 = ProductTranslation.create(:slug => 'camera')
    	assert slug1.valid?, "slug1 was not valid #{slug1.errors.inspect}"
  end
end
