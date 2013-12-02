class VisitorsController < ApplicationController


  def new
    @projects = Project.where(:public => true)
    #@projects = Project.all
  end

  def index
  end

end
