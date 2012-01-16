class OrganizationsController < ApplicationController
  # no need to load and authorize an Organization for the "index" and "states" action
  load_and_authorize_resource :organization, :except => [:index, :states]

  def index
    if request.remote_ip == '127.0.0.1'
      ip_address = nil
    else
      ip_address = request.remote_ip
      @georesult = Geocoder.search(ip_address)[0]
      @nearby_orgs = Organization.near(ip_address, 10, :limit => 4)
    end
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
