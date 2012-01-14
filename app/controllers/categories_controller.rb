class CategoriesController < ApplicationController

  load_and_authorize_resource :project
  load_and_authorize_resource :through => :project

  skip_authorize_resource :only => [:new, :show]  

  def show
    render 'projects/show'
  end

  def expenses
  end

  def revenues
  end
end
