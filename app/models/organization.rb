class Organization < ActiveRecord::Base
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

    parsed_data["response"].each do |p|
      puts p["Placename"] + ", " + p["Pop"] + ", " + p["PopSqMi"] + ", " + p["GNIS"]
      org = Organization.find_or_create_by_name_and_state(
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
  end
end
