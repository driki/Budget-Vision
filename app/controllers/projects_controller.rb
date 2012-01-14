class ProjectsController < ApplicationController

  load_resource :project
  
  def show
  end

  def categories
  end

  def expenses
    @categories = @project.categories(:type => "Expenses")
  end

  def revenues
    @categories = @project.categories(:type => "Revenues")
  end

  def borrowing
  end

  def goals
  end

  def forecasts
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'project was successfully updated.') }
        format.json { respond_with_bip(@project) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@project) }
      end
    end
  end
end
