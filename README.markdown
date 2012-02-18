Overview
-------------------
Budget Vision is an online budget presentation tool that will increase the number of people viewing your city or town budget. Budget Vision provides interactive charts and graphs that will help your citizens improve their understanding of revenue and expenses. Budget Vision allows you to provide context, history, trends and meaningful comparisons.


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
None yet. Thoughts or ideas send them Twitter @BudgetVision


Test
-------------------
Rspec, coverage is so-so. Any help there would be greatly welcome.


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
