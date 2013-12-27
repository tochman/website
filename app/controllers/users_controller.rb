class UsersController < ApplicationController
  before_filter :authenticate_user_from_token! , only: [:edit, :update]
  before_filter :authenticate_user! , only: [:edit, :update]
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :validate_authorization_for_user, only: [:edit, :update]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users
  def index
    @users = User.all
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def validate_authorization_for_user
    redirect_to root_path unless @user == current_user
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end


end