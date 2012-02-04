class GoalsController < ApplicationController
  set_tab :goals

  load_and_authorize_resource :organization, :find_by => :slug
  load_and_authorize_resource :project
  load_and_authorize_resource :goal, :except => [:new]
  before_filter :show_not_verified_alert

  def new
    @goal = @project.goals.build
  end

  def create
  	@goal = Goal.new(params[:goal])
  	@project.goals << @goal
    if @project.save
      redirect_to organization_project_goals_path(@organization, @goal.project, @goal)
    else
      render :action => 'new'
    end
  end

  def destroy   
    @goal.destroy  
    redirect_to organization_project_goals_path,
      :notice => "Successfully deleted the goal."  
  end  

  def update
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to organization_project_goals_path(@organization, @project, :notice => 'goal was successfully updated.') }
        format.json { respond_with_bip(@goal) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@goal) }
      end
    end
  end
end
