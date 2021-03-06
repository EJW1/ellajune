Ellajune::Application.routes.draw do

  match 'community_guidelines' => 'static_pages#_community_guidelines'
  match 'mission' => 'static_pages#mission'
  match 'contact' => 'static_pages#contact'
  match 'get_involved' => 'static_pages#get_involved'
  match 'how_to' => 'static_pages#how_to'

  root :to => "posts#index"

  devise_for :users

  resources :users do
    collection do
      get :autocomplete_interest_tag_name
    end
  end

  resources :posts do
    collection do
      get :autocomplete_post_tag_name
    end
  end
  
  resources :comments

  match 'votes/create' => 'votes#create', :as => :votes
  get 'post_tags/:post_tag', to: 'posts#index', as: :post_tag
  get 'interest_tags/:interest_tag', to: 'users#index', as: :interest_tag

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
