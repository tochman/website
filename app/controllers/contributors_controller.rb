class ContributorsController < ApplicationController

  require "rubygems"
  require "json"
  require "net/http"
  require "uri"
  def index

  end

  def get_json
    uri = URI.parse('https://api.github.com/repos/tansaku/LocalSupport/contributors')

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    contributors = Array.new

    if response.code == '200'
      result = JSON.parse(response.body)

      result.each do |doc|
        id = doc['id'] #reference properties like this
        login = doc['login']
        avatar = doc[avatar_url]
        contributors.push [ id,  login, avatar]

      end
    else
      contributors.push ['no contributors']
    end
  end
  end
