class ForecastsController < ApplicationController
  set_tab :forecasts

  load_and_authorize_resource :organization, :find_by => :slug
  load_and_authorize_resource :project
  load_and_authorize_resource :forecast, :except => [:new]

  def new
    @forecast = @project.forecasts.build
  end

  def create
  	@forecast = Forecast.new(params[:forecast])
  	@project.forecasts << @forecast
    if @project.save
      redirect_to project_forecasts_path(@forecast.project, @forecast)
    else
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @forecast.update_attributes(params[:forecast])
        format.html { redirect_to project_forecasts_path(@project, :notice => 'forecast was successfully updated.') }
        format.json { respond_with_bip(@forecast) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@forecast) }
      end
    end
  end
end
