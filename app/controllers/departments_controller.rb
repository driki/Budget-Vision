class DepartmentsController < CategoriesController
  load_resource :department

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
        format.html { redirect_to(@department, :notice => 'department was successfully updated.') }
        format.json { respond_with_bip(@department) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@department) }
      end
    end
  end
end