# == Schema Information
#
# Table name: product_translations
#
#  created_at        :datetime         not null
#  description       :text
#  features          :hstore
#  id                :integer          not null, primary key
#  locale            :string           not null
#  name              :string
#  product_id        :integer          not null
#  short_description :text
#  slug              :string
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_product_translations_on_locale      (locale)
#  index_product_translations_on_product_id  (product_id)
#

class ProductTranslation < ActiveRecord::Base
  belongs_to :product
  belongs_to :language, primary_key: :locale, foreign_key: :locale
  after_initialize :load_features
  before_validation :generate_slug

  private

  def load_features
    ProductTranslation.local_stored_attributes ||= {}
    ProductTranslation.local_stored_attributes[:features] ||= []

    features = Feature.all
    if features.size != ProductTranslation.local_stored_attributes[:features].size
      features.each do |feature|
        ProductTranslation.store_accessor :features, feature.id.to_s.to_sym
      end
    end
  end


  def generate_slug
    count = 0
      @slug = ProductTranslation.where(:slug => self.slug).first
      if !self.class.maximum('id').nil?
        count = self.class.maximum("id") + 1 || 1
      end

      if !@slug.blank?
        self.slug = slug.parameterize
        self.slug = "#{slug.parameterize}_#{count}"
      end
  end
  # validates_uniqueness_of locale: { scope: :category_id }
end
