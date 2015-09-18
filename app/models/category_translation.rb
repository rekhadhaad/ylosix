# == Schema Information
#
# Table name: category_translations
#
#  category_id       :integer          not null
#  created_at        :datetime         not null
#  description       :text
#  id                :integer          not null, primary key
#  locale            :string           not null
#  name              :string
#  short_description :text
#  slug              :string
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_category_translations_on_category_id  (category_id)
#  index_category_translations_on_locale       (locale)
#

class CategoryTranslation < ActiveRecord::Base
  belongs_to :category
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  # validates_uniqueness_of locale: { scope: :category_id }
  before_validation :check_slug




  private
   def check_slug
	   	count = 0
	    @slug = CategoryTranslation.where(:slug => self.slug).first
	    if !self.class.maximum('id').nil?
	      count = self.class.maximum("id") + 1 || 1
	    end

	    if !@slug.blank?
	    	self.slug = slug.parameterize
	    	self.slug = "#{slug.parameterize}_#{count}"
	    end
	end    
end
