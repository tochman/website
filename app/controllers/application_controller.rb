class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :minis
  before_action :videos_list
  helper_method :yt_client, :minis
  helper_method :resource, :resource_name, :devise_mapping


  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:dev_key => YouTubeITConfig.dev_key)
  end

  def videos_list
    results = yt_client.videos_by(:user => 'aeurdstfaksf', :tags => ['hoa'])
    #results = yt_client.videos_by(:tags => ['agile', 'ruby'])
    #results = yt_client.videos_by(:tags => ['hoa', 'leopard'], :user => 'aeurdstfaksf')
    @videos_list = results.videos
  end

  #private
  #
  #def after_sign_in_path_for(resource_or_scope)
  #  redirect_to root_path
  #end

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
        @mini_name = ([current_user.first_name, current_user.last_name].join(' '))
      else
        @mini_name = current_user.email
      end
      @mini_avatar = current_user.avatar_url(:mini) if current_user.avatar.present?
    end
  rescue
    @mini_avatar = 'anonymous_avatar.gif'
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
