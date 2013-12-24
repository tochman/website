class SubjectsController < ApplicationController

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
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def subject_params
      params.require(:subject).permit(:name, :description, :group_url, :delete)
    end

end
