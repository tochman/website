class ContributorsController < ApplicationController
  require 'rubygems'
  require 'json'

  def index
    #url = 'https://api.github.com/repos/tansaku/LocalSupport/contributors'
    url = 'https://api.github.com/orgs/AgileVentures/members'

    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    @contributors = JSON.parse(data)
  end

end
