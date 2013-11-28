Website::Application.routes.draw do
  root :to => 'visitors#new'
  get '/contributors', :to => 'contributors#index'
end
