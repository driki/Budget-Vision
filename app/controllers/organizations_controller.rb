class OrganizationsController < ApplicationController
  load_and_authorize_resource :organization

  def index
    ip_address = nil
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      ip_address = '4.21.169.0'
    else
      ip_address = request.remote_ip
    end
    @georesult = Geocoder.search(ip_address)[0]
    @nearby_orgs = Organization.near(ip_address, 4)
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
       redirect_to :action => 'show', :id => @organization
    else
      render :action => 'edit'
    end
  end

end
