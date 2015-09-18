require 'test_helper'

class CategoryTranslationTest < ActiveSupport::TestCase
 test 'should have unique slug' do
    	slug1 = CategoryTranslation.create(:slug => 'camera')
    	assert slug1.valid?, "slug1 was not valid #{slug1.errors.inspect}"
  end
end
