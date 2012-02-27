require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :nearbyfyi do
  desc "Fill database"

  task :populate_organizations => :environment do
    [Organization].each(&:delete_all)

    # states from ApplicationHelper
    states.each do |state|
      Organization.load_census(state[0])
    end
        
  end

  task :populate_projects => :environment do
    
    [Project, Category].each(&:delete_all)    
    
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: #{org.name}, #{org.state} TIME: #{Time.now.asctime}"
      org.create_stub_project
    end
  end

  task :create_org_slugs => :environment do  
    
    orgs = Organization.all
    orgs.each do |org|
      slug_friendly_name = org.name.downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
      slug_friendly_state = org.state.downcase
      puts "Creating slug: #{slug_friendly_name}-#{slug_friendly_state}"
      org.slug = slug_friendly_name+"-"+slug_friendly_state
      org.save
    end
  end

  desc "Collect official government websites"
  task :collect_websites, [:city, :state] => :environment do
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: #{org.name}, #{org.state} TIME: #{Time.now.asctime}"
      org.load_official_website
    end
  end
end