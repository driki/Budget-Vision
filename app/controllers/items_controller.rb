require 'active_record'
require 'csv'

class ItemsController < ApplicationController
  set_tab :items

  load_and_authorize_resource :organization, :find_by => :slug
  load_and_authorize_resource :project
	load_and_authorize_resource :item
	load_and_authorize_resource :category
  load_and_authorize_resource :department

  def index
    show_expenses = true
    if params[:expense] === "false"
      show_expenses = false
    end
    @items = Item.joins(:category).where(:categories => {:project_id => @project.id}).where(:is_expense => show_expenses).order("total desc")
  end

  def new
  end

  def new_bulk
    if request.post? && params[:file].present?
      file = params[:file].read

      CSV.parse(file, :headers => true) do |row|
        name        = row["NAME"]
        expense     = row["EXPENSE"]
        total       = row["TOTAL"]
        description = row["DESCRIPTION"]

        is_expense = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(expense)

        item = Item.new(:name => name, :is_expense => is_expense, :total => total, :description => description)
        @category.items << item
      end

      @category.save
      redirect_to project_category_path(@category.project, @category)
    end
  end

  def show
    @project = @category.project
  end

  def create
    @item = Item.new(params[:item])
    if !@department.nil?
  	  @category = @department
    end
    @category.items << @item
    if @category.save
      redirect_to organization_project_category_item_path(@organization, @project, @item.category, @item)
    else
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to organization_project_category_item_path(@organization, @project, @item.category,
                @item, :notice => 'Item was successfully updated.') }
        format.json { respond_with_bip(@item) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@item) }
      end
    end
  end

  def destroy   
    @item.destroy
    redirect_to organization_project_category_path(@organization, @item.category.project, @item.category),
      :notice => "Successfully deleted the item."  
  end  
end
