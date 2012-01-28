class Goal < ActiveRecord::Base
  has_paper_trail

  belongs_to :project

  attr_accessible :name,
									:description, 
									:summary

  validates_associated :project
  validates_presence_of :name, :description
end
