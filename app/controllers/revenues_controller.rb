class RevenuesController < ApplicationController
  set_tab :revenues

  load_and_authorize_resource :project
end
