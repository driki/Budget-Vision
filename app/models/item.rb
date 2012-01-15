class Item < ActiveRecord::Base
  belongs_to :category
  has_paper_trail

  acts_as_taggable
  acts_as_taggable_on :tags
end
