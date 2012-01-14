namespace :db do
  desc "Fill database"
  task :populate => :environment do
    require 'ffaker'
    
    [Organization, Project, Category, Item].each(&:delete_all)

    Organization.load_census("MA")
    
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: " + org.name + " TIME: " + Time.now.asctime

      2.times do |p|
        project = Project.new

        project.title    = Faker::Company.name
        project.description    = Faker::Lorem.paragraphs(paragraph_count = 3)
        project.summary    = Faker::Lorem.paragraphs(paragraph_count = 3)
        project.year = 1990+Random.rand(30)
        project.expense_budget = 1+Random.rand(3000000000)
        project.revenue_budget = 1+Random.rand(3000000000)
        project.average_tax_bill = 1+Random.rand(10000)


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

        item_tags = ["Wages",
                        "Supplies",
                        "Benefits",
                        "Debt Service",
                        "Equipment",
                        "Property",
                        "Miscellaneous"]
        8.times do |c|
          category = Category.new
          category.name = expense_names[c]
          category.goal = Faker::Lorem.paragraphs(paragraph_count = 1)
          category.description = Faker::Lorem.paragraphs(paragraph_count = 2)
          category.challenge = Faker::Lorem.paragraphs(paragraph_count = 1)
          category.expense_budget = 1+Random.rand(project.expense_budget)/20.75
          category.revenue_budget = 1+Random.rand(project.revenue_budget)/20.75

          20.times do |i|
            expense = Expense.new
            expense.name = Faker::Company.bs
            expense.description = Faker::Lorem.paragraphs(paragraph_count = 1)
            expense.total = 1+Random.rand(100000)
            expense.tag_list = item_tags[Random.rand(item_tags.size)]

            revenue = Revenue.new
            revenue.name = Faker::Company.bs
            revenue.description = Faker::Lorem.paragraphs(paragraph_count = 1)
            revenue.total = 1+Random.rand(100000)
            revenue.tag_list = item_tags[Random.rand(item_tags.size)]

            category.items << expense
            category.items << revenue
          end

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