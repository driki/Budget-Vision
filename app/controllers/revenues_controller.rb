class RevenuesController < ApplicationController
  set_tab :revenues

  load_and_authorize_resource :project
  load_and_authorize_resource :organization, :find_by => :slug
end
