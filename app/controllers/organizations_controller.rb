class OrganizationsController < ApplicationController
  load_resource :organization

  def index
    if request.remote_ip == '127.0.0.1'
      ip_address = nil
    else
      ip_address = request.remote_ip
      @georesult = Geocoder.search(ip_address)[0]
      @nearby_orgs = Organization.near(ip_address, 10, :limit => 4)
    end
    @recently_updated_projects = Project.order("updated_at desc").limit(20)
  end

  def states
    @organizations = Organization.find_all_by_state(params[:state_abbr]).group_by{|u| u.name[0]}
  end

  def show
    @organization = Organization.find(params[:id])
    redirect_to organization_project_path(@organization, @organization.projects.last)
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
