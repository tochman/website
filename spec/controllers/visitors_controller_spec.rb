require 'spec_helper'
require 'webmock/rspec'

describe VisitorsController do
  describe 'GET #new' do
    before :each do
      @project1 = FactoryGirl.create(:project, :public => true)
      @project2 = FactoryGirl.create(:project, :public => true)
      @project3 = FactoryGirl.create(:project, :public => false)
 
      stub_request(:get, "http://gdata.youtube.com/feeds/api/users/aeurdstfaksf/uploads?key=AI39si56zXaYYeIhrMack13lKTHuj95sOqfSHWkB2ASgI-XMH0PhI2hyl36vhS5zD2s85MkFhUBSObuNzeRBWfJn4ovqlqg5WA&max-results=25&start-index=1&v=2").
        to_return(:body => "", :status => 200, :headers => {})

      file = File.join(Rails.root, 'spec', 'data', 'api_github_repos_response.txt')
      stub_request(:get, "https://api.github.com/orgs/AgileVentures/repos").
        to_return(:body => File.read(file), :status => 200, :headers => {})
     end

    it "populates features with projects which are public" do
      get :new
      expect(assigns(:features)).to match_array([@project1, @project2])
    end

    it "does not populates features with projects which are not public" do
      get :new
      expect(assigns(:features)).to_not include @project3
    end

    it "populates repos with response data" do
      get :new
      expect(assigns(:repos).size).to eq 4
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end
end