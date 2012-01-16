class Organization < ActiveRecord::Base
  has_paper_trail
  
  validates_presence_of :name
  validates_presence_of :population

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
    elsif self.population >= 1000 && self.population <= 5000
      price = 75*12
    elsif self.population >= 5000 && self.population <= 20000
      price = 150*12
    elsif self.population >= 20000 && self.population <= 50000
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

    department_names = ["Fire Department", 
                      "General Government",
                      "Police Department",
                      "Public Works",
                      "Recreation Department",
                      "Parks & Recreation",
                      "Library",
                      "Health & Safety",
                      "School Department"]

    department_names.each do |name|
      category = Department.new
      category.name = name
      category.goal = ""
      category.description = ""
      category.challenge = ""
      category.expense_budget = 0
      category.revenue_budget = 0
      category.tag_list = "expense"

      project.categories << category
    end

    expense_names = [
                      "Debt Service",
                      "Retirement",
                      "Insurance & Employee Benefits",
                      "Miscellaneous",
                      "County Taxes",
                      "Capital Projects",
                      "Snow & Ice",
                      "Waste Disposal",
                      "Other Assesments",
                      "Other",
                      "General Assistance"]

    expense_names.each do |name|
      category = Category.new
      category.name = name
      category.goal = ""
      category.description = ""
      category.challenge = ""
      category.expense_budget = 0
      category.revenue_budget = 0
      category.tag_list = "expense"

      project.categories << category
    end

    revenue_names = ["State Aid", 
                      "Property Taxes",
                      "Local Receipts",
                      "Interest Income",
                      "Federal Stimulus",
                      "Grants",
                      "Service Fees",
                      "Other",
                      "Permits & Fees"]

    revenue_names.each do |name|
      category = Category.new
      category.name = name
      category.goal = ""
      category.description = ""
      category.challenge = ""
      category.expense_budget = 0
      category.revenue_budget = 0
      category.tag_list = "revenue"

      project.categories << category
    end

    self.projects << project
    self.save
  end

  def price
    if self.population <= 1000
      price = 350
    elsif self.population >= 1000 && self.population <= 5000
      price = 75*12
    elsif self.population >= 5000 && self.population <= 20000
      price = 150*12
    elsif self.population >= 20000 && self.population <= 50000
      price = 200*12
    elsif self.population >= 50000 && self.population <= 500000
      price = 500*12
    else
      price = 1000*12
    end

    return price
  end
end
