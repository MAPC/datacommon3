Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount ResqueWeb::Engine, at: '/resque'
  
  match '/search',  to: 'search#search',  via: :get
  match '/suggest', to: 'search#suggest', via: :get

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  resources :institutions,   only: [:show]

  resources :datasets, only: [:index, :show], concerns: :paginatable do
    match :download, to: 'datasets#download', on: :member, via: :get
  end

  resources :snapshots, only: [:index, :show] do
    member do
      get  :session_state
      post :upload_image
    end
    resources :topics,  only: [:show], on: :member, path: '', to: 'snapshots#detail'
  end

  resources :visualizations, concerns: :paginatable do
    member do
      get  :duplicate
      get  :session_state
      post :upload_image
    end
  end
  
  resources :static_maps, only: [:index, :show], concerns: :paginatable, path: 'maps'

  resources :users do
    get 'check_email',    on: :collection
    get 'check_username', on: :collection
  end
  resources :users,  except: [:edit, :update, :destroy], path: 'profiles'
  resources :profiles, only: [:edit, :update, :destroy]
  
  match '/signup', to: 'users#new', via: 'get'
  
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'signout' => 'sessions#destroy'


  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  match '', to: 'institutions#show', constraints: {subdomain: /.+/}, via: [:get]
  root      to: 'institutions#show'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
