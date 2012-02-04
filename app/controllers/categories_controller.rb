class CategoriesController < ApplicationController
  set_tab :categories

  load_and_authorize_resource :organization, :find_by => :slug
  load_and_authorize_resource :project
  load_and_authorize_resource :category, :except => [:index]

  def create
    @category = Category.new(params[:category])
    @project.categories << @category
    if @project.save
      redirect_to organization_project_category_path(@organization, @category.project, @category)
    else
      render :action => 'new'
    end
  end

  def destroy   
    @category.destroy  
    redirect_to organization_project_categories_path,
      :notice => "Successfully deleted the category."  
  end  

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to organization_project_category_path(
          @organization,
          @category.project,
          @category, :notice => 'Category was successfully updated.') }
        format.json { respond_with_bip(@category) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@category) }
      end
    end
  end

  private  
    def undo_link  
      view_context.link_to("undo", revert_version_path(@category.versions.scoped.last), :method => :post)  
    end 
end
