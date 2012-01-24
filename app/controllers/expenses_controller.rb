class ExpensesController < ApplicationController
  set_tab :expenses

  load_and_authorize_resource :project
end
