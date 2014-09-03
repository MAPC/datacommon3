Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end


  resources :institutions,   only: [:show]

  resources :layers,         only: [:index, :show], concerns: :paginatable
  resources :visualizations, only: [:index, :show, :new], concerns: :paginatable
  resources :static_maps,    only: [:index, :show], concerns: :paginatable,
                             path: 'gallery'

  resources :municipalities, only: [:index, :show] do
    resources :topics, on:    :member,        path: '',
                       only: [:show], to:   'municipalities#topic'
    get 'state/:vis_id', on: :member, to: 'municipalities#rendered_state'
  end

  resources :subregions,     only: [:index, :show] do
    resources :topics, on:    :member,        path: '',
                       only: [:show], to:   'subregions#topic'
    get 'state/:vis_id', on: :member, to: 'subregions#rendered_state'
  end

  resources :users, only: [:show], path: 'profiles'
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :page_topics, only: [:show], path: '' do
    resources :pages, only: [:show], path: ''
  end

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
