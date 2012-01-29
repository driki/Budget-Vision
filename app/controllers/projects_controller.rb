class ProjectsController < ApplicationController
  set_tab :overview

  load_and_authorize_resource :organization
  load_and_authorize_resource :project
  before_filter :show_not_verified_alert, :except => [:new, :create, :update]

  def expenses
    @categories = @project.categories(:type => "Expenses")
  end

  def revenues
    @categories = @project.categories(:type => "Revenues")
  end

  def new
    @project = @organization.projects.build
  end

  def create
    @project = Project.new(params[:project])
    @organization.projects << @project
    if @organization.save
      redirect_to organization_project_path(@project.organization, @project)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def trends
    set_tab :trends
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to organization_path(@project.organization, :notice => 'Budget was successfully updated.') }
        format.json { respond_with_bip(@project) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@project) }
      end
    end
  end
end
