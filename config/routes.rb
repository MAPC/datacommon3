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
    get 'resend_activation_email', on: :member
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

end
