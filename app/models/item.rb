class Item < ActiveRecord::Base
  belongs_to :category
  has_paper_trail

  acts_as_taggable
  acts_as_taggable_on :tags

  validates_presence_of :name
  validates_presence_of :total
  validates_associated :category

  attr_accessible :name
  attr_accessible :total
  attr_accessible :description
end
