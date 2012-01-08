class OrganizationsController < ApplicationController

  def index
    ip_address = "24.34.221.0"
    @georesult = Geocoder.search(ip_address)[0]
    @nearby_orgs = Organization.near(ip_address, 4)
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
  end
end
