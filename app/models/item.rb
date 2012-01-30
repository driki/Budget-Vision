class Item < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail

  belongs_to :category

  validates_presence_of :name
  validates_presence_of :total
  validates_associated :category

  attr_accessible :name,
    :number,
    :description,
    :is_expense,
    :total,
    :tag_list

  validates_numericality_of :total,
    :greater_than_or_equal_to => 0.00,
    :allow_nil => true,
    :message => "must be greater than 0"

  validates_length_of :description, :in => 0..1000, :allow_nil => true
end
