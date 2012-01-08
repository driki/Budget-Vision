class ProjectsController < ApplicationController

  load_and_authorize_resource :organization
  load_and_authorize_resource :through => :organization

  skip_authorize_resource :only => :new

  def expenses
    @categories = @project.categories(:type => "Expenses")
  end

  def revenues
    @categories = @project.categories(:type => "Revenues")
  end
end
