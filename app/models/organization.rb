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

  def load_official_website
    topic = nil
    website = nil
    begin
      topic = Ken::Topic.get("/en/#{name.downcase}_#{helper.states[state].downcase}")  
    rescue Exception => e
      begin
        topic = Ken::Topic.get("/en/#{name.downcase}")  
      rescue Exception => e
      end
    end
    if !topic.nil?
      webpages = topic.webpages
      #Official website pages are first and have a value of {name}
      if !webpages[0].nil? && "{name}".eql?(webpages[0]["text"])
        website = webpages[0]["url"]
        self.website = website
        self.save
      end
    end
  end

  def determine_website_vendor
    # CivicPlus
    # Archive.aspx|Archive.asp
    if Typhoeus::Request.head("#{self.website}Archive.aspx").code == 200
      return "CIVIC_PLUS"
    else
      return "UNKNOWN"
    end
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
    project.title = ""
    project.description = ""
    project.summary = ""
    project.year = Time.now.year.to_i
    project.expense_budget = 0
    project.revenue_budget = 0
    project.average_tax_bill = 0
    project.published = false
    project.save!

    self.projects << project
    self.save!
  end
end