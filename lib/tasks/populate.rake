namespace :db do
  desc "Fill database"

  task :populate_organizations => :environment do
    [Organization].each(&:delete_all)


    state_list = ["MA",
                  "ME",
                  "NH",
                  "VT",
                  "CT"
                ]
    state_list.each do |state|
      Organization.load_census(state)
    end
        
  end

  task :populate_projects => :environment do
    require 'ffaker'
    
    [Project, Category].each(&:delete_all)    
    
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: " + org.name + " TIME: " + Time.now.asctime

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
      puts "ABOUT TO SAVE: " + org.name + " TIME: " + Time.now.asctime
      org.updated_at = Time.now
      org.save
    end
  end
end