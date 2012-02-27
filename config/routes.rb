Budgetvision::Application.routes.draw do
  match "/api/v1/validation/validate_csv" => "api/v1/validations#validate_csv"
  match "/api/v1/categories/:id" => "api/v1/categories#show"

  match "/about" => redirect("/tour/about")
  match "/contact" => redirect("/tour/contact")
  match "/price" => redirect("/tour/price")
  match "/learning" => redirect("/help/learning")
  
  scope "/tour" do
    match "/about" => "home#about"
    match "/contact" => "home#contact"
    match "/help" => "home#help"
    match "/price" => "home#price"
    match "/learning" => "home#learning"
  end

  scope "/help" do
    match "/learning" => "home#learning"
  end

  match "/share/:id" => "home#share", :as => "share"
  match "/organizations/states/:state_abbr" => "organizations#states", :as => "states"  

  match '/auth/:provider/callback', :to => 'sessions#create'
  #match '/auth/failure', :to => ? TODO

  match "/login" => "sessions#login"
  match "/logout" => "sessions#destroy", :as => "logout"

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  # Google still knows about these so must redirect
  match "/organizations/:id" => "organizations#show_by_id"
  match "/projects/:id(/trends)(/comparisons)(/goals)" => "projects#show_by_id"

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
  match "/organizations" => "organizations#index", :as => "organizations"
  resources :organizations, :path => '', :except => [:index]
  resources :organizations, :path => '', :only => [] do
    resources :projects, :path => '', :except => [:index] do 
      resources :categories do 
        resources :items do
          get 'new_bulk', :on => :collection
          post 'new_bulk', :on => :collection
        end
      end
      resources :departments do 
        resources :items
      end
      resources :expenses
      resources :revenues
      resources :goals
      resources :forecasts
      resources :sources
      resources :items
      member do
        get 'trends'
        get 'comparisons'
      end
    end
  end

  resources :projects
  resources :departments
  resources :categories
  resources :expenses
  resources :revenues
  resources :goals
  resources :forecasts
  resources :sources
  resources :items

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
