class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged
  acts_as_taggable
  include RankedModel
  ranks :row_order

validates :title, :presence  => true
validates :source, :presence  => true
validates :link, :presence  => true
validates :time, :presence  => true, numericality: { only_integer: true }
validates :ingredient, :presence  => true
validates :slug, :presence  => true, :uniqueness=>true

def next
    Recipe.first(:conditions => ['row_order >?', self.row_order], :order=>'row_order ASC')
end
end
