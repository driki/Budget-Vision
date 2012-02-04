class ProjectsController < ApplicationController
  set_tab :overview

  load_and_authorize_resource :organization, :find_by => :slug
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
    @revenue_categories = @project.categories.where(:is_expense => false).roots.order("revenue_budget desc")
    @expense_categories = @project.categories.where(:is_expense => true).roots.order("expense_budget desc")

    @title = "#{@organization.name}, #{@organization.state} #{@project.year} city and town budget"
    @meta_keywords = @project.meta_keywords
  end

  def trends
    @title = "#{@organization.name}, #{@organization.state} city budget trends"
    set_tab :trends
    @project_years = Project.where(:organization_id => @project.organization.id).order("year asc").select(:year).collect(&:year)
    @expenditure_totals = Project.where(:organization_id => @project.organization.id).order("year asc").select(:expense_budget).collect(&:expense_budget)
    @revenue_totals = Project.where(:organization_id => @project.organization.id).order("year asc").select(:revenue_budget).collect(&:revenue_budget)
  end

  def comparisons
    @title = "#{@organization.name}, #{@organization.state} city budget comparisons"
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

  def destroy   
    @project.destroy  
    redirect_to organization_path(@organization),
      :notice => "Successfully deleted the budget."  
  end  

end
