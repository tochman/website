Website::Application.routes.draw do
  mount Mercury::Engine => '/'
  Mercury::Engine.routes

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users

  resources :projects do
    resources :documents do
      member { post :mercury_update }
    end
  end

  resources :videos do
    member do
      post :add_comment
    end
    new do
      post :upload
      get  :save_video
    end
  end

  resources :subjects do
    member do
      get :follow
      get :unfollow
    end
  end

  #post "videos/:id/add_comment", :to => "videos#add_comment"

  resources :subjects do
	  resources :bookings
  end

  resources 'contacts', only: [:new, :create]

  root :to => 'visitors#new'
  get 'users/:id' => 'users#show'
  get 'users/' => 'users#index'
  #get 'users/edit' => 'users#edit'
  #get "/signup"   => "users/registrations#new",   :as => :new_user_registration
  get '/contributors', :to => 'contributors#index'
  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#server_error'
  get '/500', :to => 'errors#server_error'

end
