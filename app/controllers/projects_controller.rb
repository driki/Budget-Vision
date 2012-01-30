class ProjectsController < ApplicationController
  set_tab :overview

  load_and_authorize_resource :organization
  load_and_authorize_resource :project
  before_filter :show_not_verified_alert, :except => [:new, :create, :update]

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

  def show
    @expense_categories = @project.categories.where(:is_expense => true)
    @revenue_categories = @project.categories.where(:is_expense => false)
  end

  def trends
    set_tab :trends
  end

  def comparisons
    set_tab :comparisons
    population_low = @project.organization.population*0.85
    population_high = @project.organization.population*1.15
    sq_mi_low = @project.organization.total_sq_mi*0.5
    sq_mi_hi = @project.organization.total_sq_mi*1.5
    diversity_low = @project.organization.diversity*0.85
    diversity_high = @project.organization.diversity*1.15

    @similar_orgs = Organization.where("id != ?", @project.organization.id).where(:population => (population_low)..(population_high)).where(:total_sq_mi => (sq_mi_low)..(sq_mi_hi)).where(:diversity => (diversity_low)..(diversity_high)).limit(10)
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to organization_project_path(@project.organization, @project, :notice => 'Budget was successfully updated.') }
        format.json { respond_with_bip(@project) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@project) }
      end
    end
  end
end
