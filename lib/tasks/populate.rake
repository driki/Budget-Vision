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
    
    [Project, Category].each(&:delete_all)    
    
    orgs = Organization.all
    orgs.each do |org|
      puts "STARTING: #{org.name}, #{org.state} TIME: #{Time.now.asctime}"
      org.create_stub_project
    end
  end
end