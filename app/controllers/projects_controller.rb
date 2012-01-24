class ProjectsController < ApplicationController
  set_tab :overview
  before_filter :show_welcome

  load_and_authorize_resource :project

  def expenses
    @categories = @project.categories(:type => "Expenses")
  end

  def revenues
    @categories = @project.categories(:type => "Revenues")
  end

  def edit
  end

  def show
    session[:show_project_not_verified] ||= {}
    if session[:show_project_not_verified][@project.id].nil?
      session[:show_project_not_verified][@project.id] = true
    else
      session[:show_project_not_verified][@project.id] = false
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to organization_path(@project.organization, :notice => 'project was successfully updated.') }
        format.json { respond_with_bip(@project) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@project) }
      end
    end
  end
end
