class Category < ActiveRecord::Base
  acts_as_taggable_on :tags, :tags
  has_paper_trail
  has_many :items
  belongs_to :project

  validates_presence_of :name

	attr_accessible :name,
								:goal, 
								:challenge, 
								:description, 
								:expense_budget,
								:revenue_budget,
								:tags,
								:type,
								:people

  validates_numericality_of :expense_budget,
  	:greater_than_or_equal_to => 0.00,
  	:allow_nil => true,
  	:message => "must be greater than 0"

  validates_numericality_of :revenue_budget,
  	:greater_than_or_equal_to => 0.00,
  	:allow_nil => true,
  	:message => "must be greater than 0"

  validates_length_of :description, :in => 0..2000, :allow_nil => true
  validates_length_of :goal, :in => 0..2000, :allow_nil => true
  validates_length_of :challenge, :in => 0..2000, :allow_nil => true
end