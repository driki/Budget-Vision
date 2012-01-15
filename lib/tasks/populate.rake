require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :db do
  desc "Fill database"

  task :populate_organizations => :environment do
    [Organization].each(&:delete_all)

    # states from ApplicationHelper
    states.each do |state|
      Organization.load_census(state[0])
    end
        
  end

  task :populate_projects => :environment do
    require 'ffaker'
    
    [Project, Category].each(&:delete_all)    
    
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: #{org.name}, #{org.state} TIME: #{Time.now.asctime}"

      1.times do |p|
        project = Project.new

        project.title    = ""
        project.description    = ""
        project.summary    = ""
        project.year = Time.now.year.to_i
        project.expense_budget = 0
        project.revenue_budget = 0
        project.average_tax_bill = 0

        expense_names = ["Fire Department", 
                          "General Government",
                          "Police Department",
                          "Public Works",
                          "Recreation Department",
                          "Public Safety",
                          "Debt",
                          "Other",
                          "Health & Safety",
                          "School Department"]

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
                          "Property Tax",
                          "Local Receipts",
                          "Federal Stimulus",
                          "Grants",
                          "Fees"]

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

        org.projects << project
      
      end
      puts "STARTING: #{org.name}, #{org.state} TIME: #{Time.now.asctime}\n"
      org.updated_at = Time.now
      org.save
    end
  end
end