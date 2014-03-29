Survey::Application.routes.draw do
  
  resources :diagnostics
  match "/diagnostics/:diagnostic_id/admin" => "diagnostics#admin", :as => 'diagnostic_admin'
  match "/diagnostics/:diagnostic_id/click/:x/:y/:rotation" => "diagnostics#click", :as => 'diagnostic_click'
  match "/diagnostics/:id/segment/:segment_id" => "diagnostics#show", :as => 'diagnostic_segment'
  match "/diagnostics_edit" => "diagnostics#all"
  
  resources :segments, :except => :index
  match "/segments/new/:diagnostic_id" => "segments#new", :as => 'new_segment'
  match "/segments/:segment_id/questions" => "segments#questions", :as => 'segment_questions'
  
  resources :questions, :except => :index
  match "/questions/new/:segment_id" => "questions#new", :as => 'new_question'
  match "/questions/:segment_id" => "questions#show"
  
  resources :sub_questions, :except => :index
  match "/sub_questions/new/:question_id" => "sub_questions#new", :as => 'new_sub_question'
  
  resources :users, :only => [:index, :show]
  match '/search' => 'users#index'
  
  as :user do
    get '/register', to: 'devise/registrations#new', :as => :register
    get '/login', to: 'devise/sessions#new', :as => :login
    get '/logout', to: 'devise/sessions#destroy', :as => :logout
    get '/edit', to: 'devise/registrations#edit', :as => :edit
  end
  

  devise_for :users

  get "home/index"
  root :to => "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
