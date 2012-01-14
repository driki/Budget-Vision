class Category < ActiveRecord::Base
  acts_as_taggable_on :tags, :tags
  has_paper_trail
  has_many :items
  belongs_to :project
end
