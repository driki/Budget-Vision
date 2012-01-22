class CategoriesController < ApplicationController

  load_and_authorize_resource :project
  load_and_authorize_resource :category, :except => [:index]

  def index
  end

  def show
  end

  def expenses
  end

  def revenues
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to organization_project_category_path(@category, :notice => 'category was successfully updated.') }
        format.json { respond_with_bip(@category) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@category) }
      end
    end
  end
end
