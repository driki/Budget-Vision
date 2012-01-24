class ExpensesController < ApplicationController
  set_tab :expenses

  load_and_authorize_resource :project

  def show
    session[:show_project_not_verified] ||= {}
    if session[:show_project_not_verified][@project.id].nil?
      session[:show_project_not_verified][@project.id] = true
    else
      session[:show_project_not_verified][@project.id] = false
    end
  end
end
