namespace :db do
  desc "Fill database"
  task :populate => :environment do
    require 'ffaker'
    
    [Project, Category, Item].each(&:delete_all)
    orgs = Organization.all
    orgs.each do |org|
      random_org = Random.rand(Organization.count-Organization.first.id)+Organization.first.id
      org = Organization.find(random_org)

      5.times do |p|
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

        item_types = ["Wages",
                        "Supplies",
                        "Benefits",
                        "Debt Service",
                        "Equipment",
                        "Property",
                        "Miscellaneous"]
        10.times do |c|
          category = Category.new
          category.name = expense_names[c]
          category.type = "Expenses"
          category.goal = Faker::Lorem.paragraphs(paragraph_count = 1)
          category.description = Faker::Lorem.paragraphs(paragraph_count = 2)
          category.challenge = Faker::Lorem.paragraphs(paragraph_count = 1)
          category.expense_budget = 1+Random.rand(project.expense_budget)/20.75
          category.revenue_budget = 1+Random.rand(project.revenue_budget)/20.75

          100.times do |i|
            item = Item.new
            item.name = Faker::Company.bs
            item.description = Faker::Lorem.paragraphs(paragraph_count = 1)
            item.total = 1+Random.rand(100000)
            item.is_expense = true
            item.type_list = item_types[Random.rand(item_types.size)]

            category.items << item
          end

          project.categories << category
        end

        project.save

        org.projects << project
        org.updated_at = Time.now
        
        org.save
      end
    end
  end
end