class Project < ActiveRecord::Base

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

  def meta_keywords
    expense_categories = categories.where(:is_expense => true).roots.order("expense_budget desc")
    revenue_categories = categories.where(:is_expense => false).roots.order("revenue_budget desc")

    keywords = [organization.name, organization.state, year, "city and town budget"]
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

  def self.validate_csv(url)
    data = RestClient.get(url)
    csv = CSV.parse(data)
    csv.each_with_index do |row, index|
      if row.size != 12
        raise "Row number (#{index}) :: All rows must contain 12 columns"
      end

      if !row[0].downcase.eql?("true") && !row[0].downcase.eql?("false")
        raise "Row number (#{index}) :: The first column must be either true or false"
      end

      # each row must have either a category or sub-category
      if row[1].empty? && row[4].empty?
        raise "Row number (#{index}) :: Each row must have either a category or sub-category"
      end

      # validate the parent category
      category = Category.new(:name => row[1], :expense_budget => row[2], :tag_list => row[3])
      if !category.valid?
        raise "Row number (#{index}) :: Invalid parent category"
      end

      # if a row has a sub-category it must have a parent category
      if (!row[4].empty? && !row[5].empty?) && (row[1].empty?)
        raise "Row number (#{index}) :: A sub-category must have a parent"
      end

      # validate the sub-category
      sub_category = Category.new(:name => row[4], :expense_budget => row[5], :tag_list => row[6])
      if !category.valid?
        raise "Row number (#{index}) :: Invalid sub-category"
      end

      # if a row has an item it must have a category
      if !row[7].empty? || !row[8].empty? || !row[9].empty? || !row[10].empty? || !row[11].empty?
        if !row[1].empty? && !row[4].empty?
          raise "Row number (#{index}) :: If a row has an item it must have a category"
        end
        item = Item.new(:number => row[7], :name => row[8], :description => row[9], :total => row[10], :tag_list => row[11])
        if !item.valid?
          raise "Row number (#{index}) :: Invalid item row"
        end
      end

    end
    return true
  end

  def to_csv(is_expense)
    CSV.generate do |csv|
      # IS_EXPENSE
      # CATEGORY_NAME
      # CATEGORY_AMOUNT
      # CATEGORY_TAGS
      # SUB_CATEGORY_NAME
      # SUB_CATEGORY_AMOUNT
      # SUB_CATEGORY_TAGS
      # ITEM_NUMBER
      # ITEM_NAME
      # ITEM_DESCRIPTION
      # ITEM_AMOUNT
      # ITEM_TAGS
      # csv << ["", "", "", "", "", "", "", "", "", "", "", ""]

      # all the top level categories first
      categories.where(:is_expense => is_expense).each do |category|
        csv << ["#{category.is_expense}", "#{category.name}", "#{category.expense_budget}", "", "", "", "", "", "", "", "", ""]

        # now descendants of this category
        # all the top level categories first
        category.descendants.where(:is_expense => is_expense).each do |sub_category|
          csv << ["#{category.is_expense}", "#{category.name}", "#{category.expense_budget}", "", "#{sub_category.name}", "#{sub_category.expense_budget}", "", "", "", "", "", ""]
        end
      end

      # now add all the line items
      Item.joins(:category).where(:categories => {:project_id => id}).where(:is_expense => is_expense).order("total desc").each do |item|
        csv << ["#{item.category.is_expense}", "#{item.category.parent.nil? ? item.category.name : item.category.parent.name}", "#{item.category.parent.nil? ? item.category.expense_budget : item.category.parent.expense_budget}", "", "#{item.category.parent.nil? ? '' : item.category.name}", "#{item.category.parent.nil? ? '' : item.category.expense_budget}", "", "#{item.id}", "#{item.name}", "#{item.description}", "#{item.total}", ""]
      end
    end
  end

  def taxable_revenue
  end
end
