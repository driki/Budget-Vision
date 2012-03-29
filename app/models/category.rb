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
    :tag_list,
    :people,
    :parent_id

  validates_length_of :description, :in => 0..2000, :allow_nil => true
  validates_length_of :goal, :in => 0..2000, :allow_nil => true
  validates_length_of :challenge, :in => 0..2000, :allow_nil => true

  def expenditure_items_total
    return Item.where(:category_id => subtree_ids).where(:is_expense => true).sum(:total)
  end

  def revenue_items_total
    return Item.where(:category_id => subtree_ids).where(:is_expense => false).sum(:total)
  end

  def meta_keywords    
    keywords = [project.organization.name, 
                project.organization.state, 
                project.year, 
                name, "city and town budget", ]
    descendants.each do |c|
      keywords << c.name
    end
    meta_keywords = ""
    keywords.each do |keyword|
      meta_keywords += "#{keyword}, "
    end
    return meta_keywords
  end
end