class Organization < ActiveRecord::Base
  has_paper_trail

  validates_presence_of :name, :allow_nil => false
  validates_presence_of :state, :allow_nil => false
  validates_numericality_of :population,
    :greater_than_or_equal_to => 0,
    :only_integer => true,
    :message => "must be greater than 0"

  has_many :organization_users
  has_many :users, :through => :organization_users
  has_many :projects

  reverse_geocoded_by :latitude, :longitude

  def to_param
    slug
  end

  def address
    "#{self.name}, #{self.state}"
  end

  def price
    if self.population <= 1000
      price = 350
    elsif self.population > 1000 && self.population <= 5000
      price = 75*12
    elsif self.population > 5000 && self.population <= 20000
      price = 150*12
    elsif self.population > 20000 && self.population <= 50000
      price = 200*12
    elsif self.population >= 50000 && self.population <= 500000
      price = 500*12
    else
      price = 1000*12
    end

    return price
  end

  def self.load_census(state_abbriviation)
    api_key = "8gybnk94e8uyt5vzv9enzpyz"
    url = "http://api.usatoday.com/open/census/loc?keypat=#{state_abbriviation}&sumlevid=4,6&api_key=#{api_key}"

    data = RestClient.get(url)
    parsed_data = JSON(data)

    orgs = []
    parsed_data["response"].each do |p|
      puts "PARSING: #{p['Placename']}, #{p['StatePostal']}"
      orgs << Organization.new(
                             {:name => p["Placename"],
                              :population => p["Pop"],
                              :state => p["StatePostal"],
                              :pop_sq_mi => p["PopSqMi"],
                              :total_sq_mi => p["TotSqMi"],
                              :housing_units => p["HousingUnits"],
                              :housing_percent_vacant => p["PctVacant"],
                              :latitude => p["Lat"],
                              :longitude => p["Long"],
                              :diversity => p["USATDiversityIndex"],
                              :fips => p["FIPS"],
                              :gnis => p["GNIS"]}
      )
    end
    Organization.import orgs
  end

  def create_category_hierarchy(project, tree, is_expense)
    tag_list = is_expense ? "expense" : "revenue";

    tree.each do |parent_name, children_names|
      parent = Category.new
      parent.name = parent_name
      parent.goal = ""
      parent.description = ""
      parent.challenge = ""
      parent.expense_budget = 0
      parent.revenue_budget = 0
      parent.is_expense = is_expense
      parent.tag_list = tag_list
      parent.save!

      project.categories << parent

      children_names.each do |child_name|
        child = Category.new
        child.name = child_name
        child.goal = ""
        child.description = ""
        child.challenge = ""
        child.expense_budget = 0
        child.revenue_budget = 0
        child.is_expense = is_expense
        child.tag_list = tag_list
        child.parent = parent
        child.save!

        project.categories << child
      end

      project.save!
    end
  end

  def create_stub_project
    project = Project.new

    project.organization_id = self.id
    project.title = ""
    project.description = ""
    project.summary = ""
    project.year = Time.now.year.to_i
    project.expense_budget = 0
    project.revenue_budget = 0
    project.average_tax_bill = 0
    project.published = false
    project.save!

    # Based on the Maine Muni Fiscal Survey there are parent categories and sub-categories:

    # Expense categories
    expense_hierarchy = Hash.new
    expense_hierarchy["General Admin"] = ["Employee Benefits",
      "Elected Officials",
      "Admin Offices",
      "Legal",
      "Government Buildings",
      "Economic Development"]
    expense_hierarchy["Public Safety"] = ["Police",
      "Fire",
      "EMS",
      "Street Lighting",
      "Other",
      "Capital"]
    expense_hierarchy["Public Works Roads"] = ["Administration",
      "Roads Winter",
      "Roads All Other",
      "Bridges",
      "Capital"]
    expense_hierarchy["Public Works Other"] = ["Solid Waste & Recycling",
      "Water & Sewer",
      "Capital"]
    expense_hierarchy["Code & Human Services"] = ["Code Enforcement",
      "General Assistance",
      "Social Service Contributions",
      "Other"]
    expense_hierarchy["Parks, Recreation & Library"] = ["Parks & Recreation",
      "Library",
      "Other",
      "Capital"]
    expense_hierarchy["County, Education, & Debt"] = ["County Assessment",
      "K-12 Assessment",
      "Long Term Municipal Debt",
      "Long Term Educational Debt"]

    create_category_hierarchy(project, expense_hierarchy, true)

    # Revenue categories
    revenue_hierarchy = Hash.new
    revenue_hierarchy["Municipal Revenue"] = ["Property Tax",
      "Motor Vehicle Excise Tax",
      "Watercraft Excise Tax",
      "Interest Tax",
      "License, Permits, Fees",
      "Service Fees"]
    revenue_hierarchy["State Revenue"] = ["Revenue Sharing",
      "Homestead Exemption",
      "Road Assistance",
      "General Assistance",
      "Tree Growth",
      "State Aid Education",
      "Veterans' Reimbursement",
      "Other"]
    revenue_hierarchy["Other Revenue"] = ["Federal",
      "Surplus",
      "Reserve or Trust Funds"]

    create_category_hierarchy(project, revenue_hierarchy, false)

    self.projects << project
    self.save!
  end
end