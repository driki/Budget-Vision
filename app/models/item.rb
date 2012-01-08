class Item < ActiveRecord::Base
  belongs_to :category

  acts_as_taggable
  acts_as_taggable_on :type
end
