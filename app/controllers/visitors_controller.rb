class VisitorsController < ApplicationController


  def new
    @features = Project.where(:public => true)

    #@projects = Project.all
  end

  def index
  end

end
