Budgetvision::Application.routes.draw do
  match "/about" => "home#about"
  match "/contact" => "home#contact", :as => "contact"
  match "/contact/:id" => "home#contact"
  match "/help" => "home#help"
  match "/price" => "home#price"
  match "/setup" => "home#setup"
  match "/share/:id" => "home#share", :as => "share"

  match "/organizations/states/:state_abbr" => "organizations#states", :as => "states"

  match '/auth/:provider/callback', :to => 'sessions#create'
  #match '/auth/failure', :to => ? TODO

  match "/login" => "sessions#login"
  match "/logout" => "sessions#destroy", :as => "logout"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):

  # See: http://weblog.jamisbuck.org/2007/2/5/nesting-resources
  resources :organizations do
    resources :projects, :name_prefix => "organization_"
  end

  resources :projects do
    resources :categories, :name_prefix => "project_"
    resources :expenses, :name_prefix => "project_"
    resources :revenues, :name_prefix => "project_"
    resources :goals, :name_prefix => "project_"
    resources :forecasts, :name_prefix => "project_"
  end

  resources :categories do
    resources :items, :name_prefix => "category_"
  end

  resources :departments do
    resources :items, :name_prefix => "department_"
  end

  resources :items
  resources :goals

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
