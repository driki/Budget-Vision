module ApplicationHelper
  
  def title
    base_title = "Budget Vision - The dead simple way to create and share your city or town budget."
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
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
