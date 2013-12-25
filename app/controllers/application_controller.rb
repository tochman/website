class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :minis
  before_action :videos_list
  helper_method :yt_client


  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username, :password => YouTubeITConfig.password, :dev_key => YouTubeITConfig.dev_key)
  end

  def videos_list
    client = YouTubeIt::Client.new(:username => "TOchman10@gmail.com", :password =>  "Oliver2013", :dev_key => "AI39si56zXaYYeIhrMack13lKTHuj95sOqfSHWkB2ASgI-XMH0PhI2hyl36vhS5zD2s85MkFhUBSObuNzeRBWfJn4ovqlqg5WA")
    #playlist_id = "PLHz9AyfUoiO910iTpxCA7UR7a-EQvHztE"
    #playlist = client.playlist(playlist_id)
    #@videos_list = playlist.videos
    @playlists = client.playlists('TNEWebcast')
    #results = client.videos_by(:user => 'aeurdstfaksf', :tags =>{ :include => ['#hoa', '#Hangouts On Air', '#hangoutsonair']})
    #results = yt_client.videos_by(:tags => ['agile', 'ruby'])
    #results = yt_client.videos_by(:tags => ['hoa', 'leopard'], :user => 'aeurdstfaksf'|'TNEWebcast')
    #@videos_list = results.videos
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name,
                           :last_name,
                           :avatar,
                           :organization,
                           :admin,
                           :email,
                           :password,
                           :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
      }
    end
  end

  def minis
    if current_user.present?
      if current_user.first_name.present?
        @mini_name = ([current_user.first_name, ' ', current_user.last_name].join)
      else
        @mini_name = current_user.email
      end
      @mini_avatar = current_user.avatar_url(:mini)
    end
  end

end
