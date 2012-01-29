class Project < ActiveRecord::Base

  default_scope where(:published => true)

  has_paper_trail
  
  belongs_to :organization
  has_many :categories
  has_many :goals
  has_many :forecasts
  has_many :sources

	attr_accessible :year,
									:title, 
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
  	:allow_nil => true,
  	:message => "must be greater than 0"

  validates_numericality_of :expense_budget,
  	:greater_than_or_equal_to => 0.00,
  	:allow_nil => true,
  	:message => "must be greater than 0"

  validates_numericality_of :revenue_budget,
  	:greater_than_or_equal_to => 0.00,
  	:allow_nil => true,
  	:message => "must be greater than 0"

  validates_length_of :description, :in => 0..2000, :allow_nil => true
  validates_length_of :summary, :in => 0..2000, :allow_nil => true
  validates_length_of :title, :in => 0..150, :allow_nil => true

  def items
    @items = Item.joins(:category).where(:categories => {:project_id => id})
  end

  # A budget gets points the more detail it adds
  def budget_vision_score
    score = 0
    if !expense_budget.nil? && expense_budget > 0
      score = score+5
    end

    if !revenue_budget.nil? && revenue_budget > 0
      score = score+5
    end

    if !average_tax_bill.nil? && average_tax_bill > 0
      score = score+5
    end

    if !description.nil? && description.length > 0
      score = score+1
    end

    if !summary.nil? && summary.length > 0
      score = score+1
    end

    sources.each do |source|
      score = score+3
    end

    categories.each do |category|
      if !category.expense_budget.nil? && category.expense_budget > 0
        score = score+2
      end
      if !category.revenue_budget.nil? && category.revenue_budget > 0
        score = score+2
      end
    end

    return score
  end

  def taxable_revenue
  end
end
