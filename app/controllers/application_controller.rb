class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :minis
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

  #before_filter :authenticate_user!
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
