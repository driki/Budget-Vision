class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :categories
  has_many :goals
  has_many :forecasts
end
