class DepartmentsController < CategoriesController
    load_and_authorize_resource :department

  def show
    @project = @department.project
  end

  def expenses
  end

  def revenues
  end

  def update
    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to organization_project_category_path(
                @department.project.organization,
                @department.project,
                @department, :notice => 'Department was successfully updated.') }
        format.json { respond_with_bip(@department) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@department) }
      end
    end
  end
end