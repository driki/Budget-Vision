class ExpensesController < ApplicationController
  set_tab :expenses

  load_and_authorize_resource :project
  load_and_authorize_resource :organization, :find_by => :slug
end
