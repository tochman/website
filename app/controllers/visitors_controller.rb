class VisitorsController < ApplicationController
  include GetFeedModule

  def new
    @features = Project.where(:public => true)
    @repos = get_repos
    #@projects = Project.all
  end

  def index
  end

  private

    def get_repos
      get_feed('https://api.github.com/orgs/AgileVentures/repos')
      @repos = JSON.parse(@data)
    end



end
