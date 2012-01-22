class DepartmentsController < CategoriesController
  set_tab :categories

  load_and_authorize_resource :project
  load_and_authorize_resource :department, :except => [:index]

  def update
    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to project_category_path(
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