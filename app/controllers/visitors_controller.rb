class VisitorsController < ApplicationController


  def new
    @features = Project.where(:public => true)
    @repos = get_repos
    #@projects = Project.all
  end

  def get_repos
    url = 'https://api.github.com/orgs/AgileVentures/repos'

    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    @repos = JSON.parse(data)
  end

  def index
  end



end
