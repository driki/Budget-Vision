class ItemsController < ApplicationController

	load_and_authorize_resource :item
	load_and_authorize_resource :category

  def show
  end

  def new
    @item = @category.items.build
  end

  def create
  	@item = Item.new(params[:item])
  	@category.items << @item
    if @category.save
      redirect_to category_item_path(@item.category, @item)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to item_path(
                @item, :notice => 'Item was successfully updated.') }
        format.json { respond_with_bip(@item) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@item) }
      end
    end
  end
end
