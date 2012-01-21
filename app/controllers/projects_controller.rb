class ProjectsController < ApplicationController

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

  def show_welcome
    if session[:show_welcome].nil?
      session[:show_welcome] = true
    else
      session[:show_welcome] = false
    end
  end
end
