class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!
  def all
    p env["omniauth.auth"]
    user = User.from_omniauth(env["omniauth.auth"], current_user)
    if user.persisted?
      flash[:notice] = "Connected! Go to edit profile to see the status for the accounts"
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
     redirect_to subjects_path , :flash => { :error => "This did not work out! Try again" }
    return
    #super
  end


  alias_method :facebook, :all
  #alias_method :twitter, :all
  #alias_method :linkedin, :all
  alias_method :github, :all
  #alias_method :passthru, :all
  alias_method :google_oauth2, :all
  #alias_method :dropbox, :all
end