require 'csv'

class ItemsController < ApplicationController
  set_tab :items

  load_and_authorize_resource :project
	load_and_authorize_resource :item
	load_and_authorize_resource :category
  load_and_authorize_resource :department

  def index
    @items = Item.joins(:category).where(:categories => {:project_id => @project.id}).order("total desc")
  end

  def new
  end

  def new_bulk
    if request.post? && params[:file].present?
      file = params[:file].read
      n, errs = 0, []

      CSV.parse(file) do |row|
      end
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
      redirect_to category_item_path(@item.category, @item)
    else
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to category_item_path(@item.category,
                @item, :notice => 'Item was successfully updated.') }
        format.json { respond_with_bip(@item) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@item) }
      end
    end
  end
end
