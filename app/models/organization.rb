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

  def create_stub_project
    project = Project.new

    project.organization_id = self.id
    project.title    = ""
    project.description    = ""
    project.summary    = ""
    project.year = Time.now.year.to_i
    project.expense_budget = 0
    project.revenue_budget = 0
    project.average_tax_bill = 0
    project.published = true
    project.save!

    # Based on the Maine Muni Fiscal Survey
    # There are parent categories and sub-categories
    # These are Expense categories
    expense_parent_categories = Hash.new
    expense_parent_categories["General Admin"] = ["Employee Benefits", 
                                                    "Elected Officials",
                                                    "Admin Offices",
                                                    "Legal",
                                                    "Government Buildings",
                                                    "Economic Development"]
    expense_parent_categories["Public Safety"] = ["Police",
                                            "Fire",
                                            "EMS",
                                            "Street Lighting",
                                            "Other",
                                            "Capital"]
    expense_parent_categories["Public Works Roads"] = ["Administration",
                                                "Roads Winter",
                                                "Roads All Other",
                                                "Bridges",
                                                "Capital"]
    expense_parent_categories["Public Works Other"] = ["Solid Waste & Recycling",
                                                "Water & Sewer",
                                                "Capital"]
    expense_parent_categories["Code & Human Services"] = ["Code Enforcement",
                                                    "General Assistance",
                                                    "Social Service Contributions",
                                                    "Other"]
    expense_parent_categories["Parks, Recreation & Library"] = ["Parks & Recreation",
                                                        "Library",
                                                        "Other",
                                                        "Capital"]
    expense_parent_categories["County, Education, & Debt"] = ["County Assesment",
                                                      "K-12 Assesment",
                                                      "Long Term Municipal Debt",
                                                      "Long Term Educational Debt"]
    
    expense_parent_categories.each do |parent_category|
      parent = Category.new
      parent.name = parent_category.first
      parent.goal = ""
      parent.description = ""
      parent.challenge = ""
      parent.expense_budget = 0
      parent.revenue_budget = 0
      parent.tag_list = "expense"
      parent.save

      # now add the descendents for this category
      parent_category[1].each do |child_category|
        child = Category.new
        child.name = child_category
        child.goal = ""
        child.description = ""
        child.challenge = ""
        child.expense_budget = 0
        child.revenue_budget = 0
        child.tag_list = "expense"
        child.save
        child.move_to_child_of(parent)
      end

      project.categories << parent
    end


    # Based on the Maine Muni Fiscal Survey
    # There are parent categories and sub-categories
    # These are Revenue categories
    revenue_parent_categories = Hash.new
    revenue_parent_categories["Municipal Revenue"] = ["Property Tax", 
                                                      "Motor Vehicle Excise Tax",
                                                      "Watercraft Excise Tax",
                                                      "Interest Tax",
                                                      "License, Permits, Fees",
                                                      "Service Fees"]
    revenue_parent_categories["State Revenue"] = ["Revenue Sharing",
                                                  "Homestead Exemption",
                                                  "Road Assistance",
                                                  "General Assistance",
                                                  "Tree Growth",
                                                  "State Aid Education",
                                                  "Vetrans' Reimbursment",
                                                  "Other"]
    revenue_parent_categories["Other Revenue"] = ["Federal",
                                                  "Surplus",
                                                  "Reserve or Trust Funds"]
    
    revenue_parent_categories.each do |parent_category|
      parent = Category.new
      parent.name = parent_category.first
      parent.goal = ""
      parent.description = ""
      parent.challenge = ""
      parent.expense_budget = 0
      parent.revenue_budget = 0
      parent.tag_list = "revenue"
      parent.save

      # now add the descendents for this category
      parent_category[1].each do |child_category|
        child = Category.new
        child.name = child_category
        child.goal = ""
        child.description = ""
        child.challenge = ""
        child.expense_budget = 0
        child.revenue_budget = 0
        child.tag_list = "revenue"
        child.save
        child.move_to_child_of(parent)
      end

      project.categories << parent
    end

    self.projects << project
    self.save
  end
end
