module ApplicationHelper
  
  def title
    app_name = "Budget Vision"
    base_title = "Improve understanding of your city budget"
    if @title.nil?
      "#{app_name} - #{base_title}"
    else
      "#{@title} from #{app_name}"
    end
  end
  
  def meta_keywords
    keywords = ""
    if !@meta_keywords.nil?
      keywords = @meta_keywords
    end
    return keywords
  end

  def meta_description
    app_name = "Budget Vision"
    base_description = "is an online budget presentation tool that helps citizens understand city and town budgets."
    if @meta_description.nil?
      "#{app_name} #{base_description}"
    else
      "#{app_name} #{@meta_description}"
    end
  end

  def location_name(remote_ip)
    location_name = nil
    location = GeoIP.new('GeoLiteCity.dat').city(remote_ip)
    unless location.nil?
      location_name = "#{location.city_name}, #{location.region_name}"
    end
    return location_name
  end

  def show_not_verified_alert
    return true
  end

  def states
    states = {
      'AL' => 'Alabama',
      'AK' => 'Alaska',
      'AS' => 'America Samoa',
      'AZ' => 'Arizona',
      'AR' => 'Arkansas',
      'CA' => 'California',
      'CO' => 'Colorado',
      'CT' => 'Connecticut',
      'DE' => 'Delaware',
      'DC' => 'District of Columbia',
      'FM' => 'Micronesia',
      'FL' => 'Florida',
      'GA' => 'Georgia',
      'GU' => 'Guam',
      'HI' => 'Hawaii',
      'ID' => 'Idaho',
      'IL' => 'Illinois',
      'IN' => 'Indiana',
      'IA' => 'Iowa',
      'KS' => 'Kansas',
      'KY' => 'Kentucky',
      'LA' => 'Louisiana',
      'ME' => 'Maine',
      'MH' => 'Islands',
      'MD' => 'Maryland',
      'MA' => 'Massachusetts',
      'MI' => 'Michigan',
      'MN' => 'Minnesota',
      'MS' => 'Mississippi',
      'MO' => 'Missouri',
      'MT' => 'Montana',
      'NE' => 'Nebraska',
      'NV' => 'Nevada',
      'NH' => 'New Hampshire',
      'NJ' => 'New Jersey',
      'NM' => 'New Mexico',
      'NY' => 'New York',
      'NC' => 'North Carolina',
      'ND' => 'North Dakota',
      'OH' => 'Ohio',
      'OK' => 'Oklahoma',
      'OR' => 'Oregon',
      'PW' => 'Palau',
      'PA' => 'Pennsylvania',
      'PR' => 'Puerto Rico',
      'RI' => 'Rhode Island',
      'SC' => 'South Carolina',
      'SD' => 'South Dakota',
      'TN' => 'Tennessee',
      'TX' => 'Texas',
      'UT' => 'Utah',
      'VT' => 'Vermont',
      'VI' => 'Virgin Island',
      'VA' => 'Virginia',
      'WA' => 'Washington',
      'WV' => 'West Virginia',
      'WI' => 'Wisconsin',
      'WY' => 'Wyoming'
    }
    return states
  end

  def full_state_name(abbreviation)
    state_name = states.[](abbreviation)
  end
end
