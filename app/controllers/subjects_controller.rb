class SubjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :js, :json

  def index
    @subjects = Subject.all

  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.create(subject_params)
    if @subject.save
      name = @subject.name
      redirect_to subjects_path
      flash[:notice] = "#{name} created"
    else
      render 'new'
      flash[:error] = "Unable to create subject. Please try again"
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to subjects_path
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update subject_params
    if @subject.save
      flash[:notice] = "Your subject was updated succesfully"
      redirect_to subject_path
    else
      render 'edit'
    end
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def follow
    @subject = Subject.find(params[:id])
    if current_user
      current_user.follow(@subject)

       redirect_to subjects_path
      flash[:notice] = "You just joined #{@subject.name}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@subject.name}.".html_safe
    end
  end

  def unfollow
    @subject = Subject.find(params[:id])
    current_user.stop_following(@subject)

    redirect_to subjects_path
    flash[:notice] = "You are no longer a member of #{@subject.name}."
  end


  private

  def subject_params
    params.require(:subject).permit(:name, :description, :group_url, :delete)
  end

end
