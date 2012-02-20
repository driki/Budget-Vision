class Api::V1::ValidationsController < ApplicationController
  
  def validate_csv
    render :text => Project.validate_csv(params[:url])
  end
end