class CategoriesController < ApplicationController
  set_tab :categories

  load_and_authorize_resource :project
  load_and_authorize_resource :category, :except => [:index]

  def create
    @category = Category.new(params[:category])
    @project.categories << @category
    if @project.save
      redirect_to project_category_path(@category.project, @category)
    else
      render :action => 'new'
    end
  end


  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to project_category_path(
          @category.project,
          @category, :notice => 'Category was successfully updated.') }
        format.json { respond_with_bip(@category) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@category) }
      end
    end
  end
end
