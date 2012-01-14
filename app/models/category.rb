class Category < ActiveRecord::Base
  acts_as_taggable_on :tags, :tags
  has_many :items
  belongs_to :project
end
