class GoalsController < ApplicationController
  set_tab :goals

  load_and_authorize_resource :project
end
