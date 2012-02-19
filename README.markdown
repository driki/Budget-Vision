Overview
-------------------
Budget Vision is an online budget presentation tool that will increase the number of people viewing your city or town budget. Budget Vision provides interactive charts and graphs that will help your citizens improve their understanding of goals, forecasts, trends and revenue/expense line items. Budget Vision allows you to provide context, history and meaningful comparisons.

What problem does Budget Vision attempt to address?
-------------------
Budget Vision makes city and town budgets easier to understand. Budget Vision is domain specific to municipal budgets, models, views and tools are specific to supporting the effort to allow the public to more easily understand city and town budgets.

How is Budget Vision different than other solutions?
-------------------
We started down this path because the existing tools were not focused enough. Socrata, Wordpress and Freebase/Refine have all been useful tools for explaining portions of budgets but the general tools must be pieced together. Budget Vision is specifically designed for collecting, visualizing, comparing and explaining city budgets, it is not a generic open data platform.

Other solutions to consider
-------------------
Socrata
* Making Data Social
* More time to build apps. Less time worrying about the data.
* https://opendata.socrata.com/ & http://www.socrata.com/solutions/socrata-for-developers/
* Large cities and towns are using Socrata as part of their Open/Transparency initiatives. Developers can use that open data to build tools.

Wordpress
* A better way to blog
* http://www.wordpress.com
* A web and blog publishing platform for narrative text. Cities could create a blog post for each section of their budget and then use tools like Socrata, Freebase and Google Fusion Tables to provide data and visualizations that explain the budget.

Google Fusion Tables & Google Docs
* Create and share your work online and access your documents from anywhere. Manage documents, spreadsheets, presentations, surveys, and more all in one place.
* http://www.google.com/fusiontables/Home/

Excel/Powerpoint
* We all know what these are... static but highly specific, no access to data.

Freebase
* http://www.freebase.com/
* An entity graph of people, places and things, built by a community that loves open data.

Installing
-------------------
* Budget Vision is a Rails 3.1 app using Bundler
* A running implementation of Budget Vision can be found here: http://www.budgetvision.com
* git clone git@github.com:driki/Budget-Vision.git budgetvision
* cd budgetvision
* bundle install
* Create a development database called budgetvision_dev

Load data to use the web app
-------------------
* Populate the database: rake db:populate_organizations
* Create slugs for all the Organizations that were generated: rake db:create_org_slugs
* Optionally create stub projects for each organization with: rake db:populate_projects

Local environment variables
-------------------
You need to set the following local environment variables

* export OMNI_AUTH_FULL_HOST=http://budgetvision.local:3000
* export TWITTER_KEY=YOUR_KEY_HERE
* export TWITTER_SECRET=YOUR_SECRET_HERE
* export FACEBOOK_KEY=YOUR_KEY_HERE
* export FACEBOOK_SECRET=YOUR_SECRET_HERE
* export GOOGLE_ANALYTICS=YOUR_GA_TRACKER_CODE_HERE

Start Rails
-------------------
* rails s


Models & Persistence
-------------------
Currently data is stored using ActiveRecord backed by a SQL database. We've continued to explore other document based systems as possible replacements for the SQL implementation as it might allow more flexibility in the models. For now we're sticking with SQL until we hit a solid reason.

* Organizations (cities and towns)
* Projects (budgets) belong_to an Organization
* Categories (departments) belong_to Projects
* Items (line items in a budget, expenses and revenues) belong_to Categories
* Forecasts are used to help describe long term projections associated with a Project
* Goals similar to Forecasts
* OrganizationUsers
* Sources are used to reference original material, urls usually.
* Tags for more flexible organization or categorization (salary)
* Users belong_to Organizations

CSS
-------------------
* Twitter Bootstrap: http://twitter.github.com/bootstrap/

Authentication
-------------------
* OmniAuth: https://github.com/intridea/omniauth


Loading data
-------------------

Individual line items
-------------------
Budget Vision provides a UI to create Projects, Categories and Items. Users need to be logged in to edit any data. An Organization can lock down who can perform CRUD operations by setting is_verified = true and then adding Users to that Organization. There is currently no user interface for adding and managing OrganizationUsers.

Bulk line item addition
-------------------
ItemsController.new_bulk is partially fleshed out. It needs work and protection against bad data. There is currently no visible link in the UI to access this controller and it's actions. We've spent time looking at how best to get data from cities and towns into Budget Vision and it appears that expecting a town to upload a CSV seems out of reach.

We expect to create an API for import/export of all the data and then create collection agents that interact with the popular ERP and accounting systems that municipalities use. An example would be to create a collector for TylerTechnologies MUNIS accounting product as nearly 10,000 cities and towns use that system.


API
-------------------
None yet but coming. Thoughts or ideas send them Twitter @BudgetVision


Test
-------------------
Rspec, coverage is so-so. Any help there would be greatly welcome.


Roadmap
-------------------
# Narrative budgets
We're building out methods that allow cities and towns to provide narrative and context alongside the raw data and charts. Budgets are presented to the public, Budget Vision should improve that experience for both those presenting but also those consuming the information. The work currently being performed in this area is User Experience focused. We are speaking with city officials, showing them mockups and wireframes to test out ideas.

# API
Creating an API that provides both publishing and export will allow other developers to write collection and publishing tools. It isn't clear that we should spend out time building out the API infrastructure that developers expect or if we plug into one of the services like Mashery or Apigee.

# Standards
Much like Open311 has done we would like to see an OpenBudget/Finance standard evolve out of the Budget Vision work. OpenBudget could then become a standard that the major ERP providers like TylerTechnologies would need to start supporting and provide standard access to budget and finance information.

# Collection agents for major accounting systems
In our testing we've found that cities and towns are unable to provide CSV or Excel documents that can be parsed easily. We propose creating a series of collection agents that cities and towns run side by side with their ERP and accounting systems that are OpenBudget compliant . The first agent that we are looking to create is for the TylerTechnologies MUNIS system.

# Plugins
We want to lower the friction for new ideas and concepts to emerge. Budget Vision users will have the ability to install plugins that allow for modification, customization and enhance a Budget Vision instance.

# Peer-to-Peer Budget Vision instances.
We believe that cities and towns using Budget Vision will benefit from participating in a shared budget network. We also realize that not every city or town will want to use the service that NearbyFYI Inc. provides. Some cities will want to setup and run their own instances of Budget Vision, we want to encourage and support that, but we also want to make sure that other cities and towns benefit from that Budget Vision information as well.

# Themes
Cities and towns seem to choose branded solutions, we'd like to develop Budget Vision with theming in mind.

# Analysis
Once Budget Vision has data from across a significant number of municipalities we intend to start analyzing that data to provide more information that can help inform and improve the budgeting process. An example of a goal in this area would be to inform a city in the Northeast that spends $200,000 on road salt how a community nearby, with similar snowfall last year was able to get by with $125,000 of road salt.

# Other data
As Budget Vision stabilizes we will look to identify other data from municipalities that are of interest.


Trademark Policy (Borrowed liberally from WordPress)
-------------------
NearbyFYI Inc. owns and oversees the trademarks for the Budget Vision name. We have developed this trademark usage policy with the following goals in mind:

* We’d like to make it easy for anyone to use the Budget Vision name for community-oriented efforts that help spread and improve Budget Vision.
* We’d like to make it clear how Budget Vision related businesses and projects can (and cannot) use the Budget Vision name.
We’d like to make it hard for anyone to use the Budget Vision name to unfairly profit from, trick or confuse people who are looking for official Budget Vision resources.

Budget Vision Trademark Usage Policy

Permission from NearbyFYI Inc. is required to use the Budget Vision name as part of any project, product, service, domain or company name.

We will grant permission to use the Budget Vision name and logo for projects that meet the following criteria:

* The primary purpose of your project is to promote the spread and improvement of the Budget Vision software.
* Your project is non-commercial in nature (it can make money to cover its costs or contribute to non-profit entities, but it cannot be run as a for-profit project or business).
* Your project neither promotes nor is associated with entities that currently fail to comply with the GPL license under which WordPress is distributed.
* If your project meets these criteria, you will be permitted to use the Budget Vision name to promote your project in any way you see fit with one exception: Please do not use Budget Vision as part of a domain name. Examples of projects in this category are officially recognized Budget Vision products or international Budget Vision communities that are dedicated to the translation and distribution of Budget Vision in their respective countries.

Use of the Budget Vision name is additionally allowed in the following situations:

* You are using the Budget Vision name on a site that has been approved by NearbyFYI Inc.
* All other Budget Vision related businesses or projects can use the Budget Vision name and logo to refer to and explain their services, but they cannot use them as part of a product, project, service, domain, or company name and they cannot use them in any way that suggests an affiliation with or endorsement by NearbyFYI Inc. or the Budget Vision open source project. For example, a consulting company can describe its business as “123 Web Services, offering Budget Vision consulting for small businesses,” but cannot call its business “The Budget Vision Consulting Company.” Similarly, a business related to Budget Vision themes can describe itself as “XYZ Themes, the world’s best Budget Vision themes,” but cannot call itself “The Budget Vision Theme Portal.”

Similarly, it’s OK to use the Budget Vision name as part of a page that describes your products or services, but it is not OK to use it as part of your company or product logo or branding itself. Under no circumstances is it permitted to use Budget Vision as part of a top-level domain name.

We do not allow the use of the trademark in advertising, including AdSense/AdWords.

Please note that it is not the goal of this policy to limit commercial activity around Budget Vision. We encourage Budget Vision based businesses, as long as they are in compliance with this policy.

The abbreviation “BV” is not covered by the Budget Vision trademarks and you are free to use it in any way you see fit.

When in doubt about your use of the Budget Vision name, please contact NearbyFYI Inc. for clarification.
