class Project < ActiveRecord::Base

  has_paper_trail
  
  belongs_to :organization
  has_many :categories
  has_many :goals
  has_many :forecasts
  has_many :sources
end
