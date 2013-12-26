Website::Application.routes.draw do
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

  devise_for :users

  resources :subjects do
	  resources :bookings
  end
  resources :projects


  root :to => 'visitors#new'
  get 'users/:id' => 'users#show'
  get 'users/' => 'users#index'
  get '/contributors', :to => 'contributors#index'
  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#server_error'
  get '/500', :to => 'errors#server_error'
end
