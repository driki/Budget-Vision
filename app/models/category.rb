class Category < ActiveRecord::Base
  acts_as_taggable
  has_ancestry
  has_paper_trail

  has_many :items
  belongs_to :project

  validates_presence_of :name

	attr_accessible :name,
    :goal,
    :challenge,
    :description,
    :is_expense,
    :expense_budget,
    :revenue_budget,
    :tag_list,
    :people,
    :parent_id

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

  def meta_keywords
    expense_categories = descendants.where(:is_expense => true).roots.order("expense_budget desc")
    revenue_categories = descendants.where(:is_expense => false).roots.order("revenue_budget desc")

    keywords = [project.organization.name, project.organization.state, project.year, name, "city and town budget"]
    expense_categories.each do |c|
      keywords << c.name
    end
    revenue_categories.each do |c|
      keywords << c.name
    end
    meta_keywords = ""
    keywords.each do |keyword|
      meta_keywords += "#{keyword}, "
    end
    return meta_keywords
  end
end