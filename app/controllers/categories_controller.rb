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
  
  def show
    @title = "#{@organization.name}, #{@organization.state} #{@project.year} #{@category.name} budget"
    @meta_keywords = @category.meta_keywords
    @category_expenditures_total = Item.where(:category_id => @category.subtree_ids).where(:is_expense => true).sum(:total)
    @category_revenues_total = Item.where(:category_id => @category.subtree_ids).where(:is_expense => false).sum(:total)
    @child_categories = @category.children
    @categories_by_total = Hash.new
    @child_categories.each do |cat|
      @categories_by_total[cat.expenditure_items_total] = cat
    end
    @categories_by_total = Hash[@categories_by_total.sort.reverse]
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
