class Project < ActiveRecord::Base

  has_paper_trail
  
  belongs_to :organization
  has_many :categories
  has_many :goals
  has_many :forecasts
  has_many :sources

	attr_accessible :year, 
									:average_tax_bill, 
									:expense_budget, 
									:revenue_budget,
									:description,
									:summary,
									:enable_comments,
									:enable_tips,
									:is_demo

  validates_associated :organization
  validates_presence_of :year

	validates_numericality_of :year,
  	:greater_than_or_equal_to => 1900,
  	:only_integer => true,
  	:message => "must be greater than 1900"

  validates_numericality_of :average_tax_bill,
  	:greater_than_or_equal_to => 0.00,
  	:message => "must be greater than 0"

  validates_numericality_of :expense_budget,
  	:greater_than_or_equal_to => 0.00,
  	:message => "must be greater than 0"

  validates_numericality_of :revenue_budget,
  	:greater_than_or_equal_to => 0.00,
  	:message => "must be greater than 0"

  validates_length_of :description, :in => 0..2000, :allow_nil => true
  validates_length_of :summary, :in => 0..2000, :allow_nil => true

  validates :enable_comments, :inclusion => {:in => [true, false]}
end
