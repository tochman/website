class ContributorsController < ApplicationController
  include GetFeedModule
  require 'rubygems'
  require 'json'

  def index
    get_feed('https://api.github.com/orgs/AgileVentures/members')
    #url = 'https://api.github.com/repos/tansaku/LocalSupport/contributors'
    #url = 'https://api.github.com/orgs/AgileVentures/members'
    #
    #response = Net::HTTP.get_response(URI.parse(url))
    #data = response.body
    @contributors = JSON.parse(@data)
  end

end
