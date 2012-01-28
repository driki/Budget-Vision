class Item < ActiveRecord::Base
  belongs_to :category
  has_paper_trail

  acts_as_taggable
  acts_as_taggable_on :tags

  validates_presence_of :name
  validates_presence_of :total
  validates_associated :category

  attr_accessible :name,
                :number, 
                :description, 
                :total, 
                :tag_list

  validates_numericality_of :total,
    :greater_than_or_equal_to => 0.00,
    :allow_nil => true,
    :message => "must be greater than 0"

  validates_length_of :description, :in => 0..1000, :allow_nil => true
end
