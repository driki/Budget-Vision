class OrganizationsController < ApplicationController
  # no need to load and authorize an Organization for the "index" and "states" action
  load_and_authorize_resource :organization, :except => [:index, :states]

  def index
    @location = GeoIP.new('GeoLiteCity.dat').city(remote_ip)
    @nearby_orgs = Organization.near([@location.latitude, @location.longitude], 10, :limit => 8)
    @recently_updated_projects = Project.order("updated_at desc").limit(10)
  end

  def states
    @organizations = Organization.find_all_by_state(params[:state_abbr]).group_by{|u| u.name[0]}
  end

  def show
    # the first time that an organization is viewed it won't have any projects
    # so create one as a stub for people to start with
    if @organization.projects.empty?
      @organization.create_stub_project
    end
    redirect_to organization_project_path(@organization, @organization.projects.last)
  end

  def edit

  end

  def update
    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to(@organization, :notice => 'organization was successfully updated.') }
        format.json { respond_with_bip(@organization) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@organization) }
      end
    end
  end
end
