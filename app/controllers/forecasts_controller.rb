class ForecastsController < ApplicationController
  set_tab :forecasts

  load_and_authorize_resource :project
end
