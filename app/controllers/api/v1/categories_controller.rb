class Api::V1::CategoriesController < ApplicationController
  
  def show
    respond_to do |format|
      format.json{
        @expense_categories = Project.find_by_id(params[:id]).categories.where(:is_expense => true).roots
        @revenue_categories = Project.find_by_id(params[:id]).categories.where(:is_expense => false).roots
        render :partial => "api/v1/category.json"
      }
    end
  end
end