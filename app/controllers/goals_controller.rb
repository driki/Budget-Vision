class GoalsController < ApplicationController
  set_tab :goals

  load_and_authorize_resource :project
  load_and_authorize_resource :goal, :except => [:new]

  def show
    session[:show_project_not_verified] ||= {}
    if session[:show_project_not_verified][@project.id].nil?
      session[:show_project_not_verified][@project.id] = true
    else
      session[:show_project_not_verified][@project.id] = false
    end
  end

  def new
    @goal = @project.goals.build
  end

  def create
  	@goal = Goal.new(params[:goal])
  	@project.goals << @goal
    if @project.save
      redirect_to project_goals_path(@goal.project, @goal)
    else
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to project_goals_path(@project, :notice => 'goal was successfully updated.') }
        format.json { respond_with_bip(@goal) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@goal) }
      end
    end
  end
end
