class Api::V1::CategoriesController < ApplicationController
  
  def show
    respond_to do |format|
      format.json{
      	is_expense = false
      	if params[:is_expense]
      		is_expense = true
      	end
        @categories = Project.find_by_id(params[:id]).categories.where(:is_expense => is_expense).roots
        render :partial => "api/v1/category.json"
      }
    end
  end
end