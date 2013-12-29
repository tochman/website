require 'spec_helper'
require 'webmock/rspec'

describe SubjectsController do
  before :each do
    stub_request(:get, "http://gdata.youtube.com/feeds/api/users/aeurdstfaksf/uploads?key=AI39si56zXaYYeIhrMack13lKTHuj95sOqfSHWkB2ASgI-XMH0PhI2hyl36vhS5zD2s85MkFhUBSObuNzeRBWfJn4ovqlqg5WA&max-results=25&start-index=1&v=2").
      to_return(:body => "", :status => 200, :headers => {})
  end

  describe 'GET #index' do
    it "populates an array of subjects" do
      @subject1 = create(:subject)
      @subject2 = create(:subject, name: 'Sub')
      get :index
      expect(assigns(:subjects)).to match_array([@subject1, @subject2])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before :each do 
      @controller.stub(:authenticate_user!).and_return(true)
    end
    
    it "assigns a new Subject to @subject" do
      get :new
      expect(assigns(:subject)).to be_a_new(Subject)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before :each do 
      @controller.stub(:authenticate_user!).and_return(true)
    end

    context "with valid attributes" do
      it "saves the new subject in the database" do
        expect {
          post :create, subject: attributes_for(:subject)
        }.to change(Subject, :count).by(1)
      end

      it "redirects to subjects#show" do
        post :create, subject: attributes_for(:subject)
        expect(response).to redirect_to subjects_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new subject in the database" do
        expect {
          post :create, subject: attributes_for(:invalid_subject)
        }.to_not change(Subject, :count)
      end

      it "re-renders the :new template" do
        post :create, subject: attributes_for(:invalid_subject)
        expect(response).to render_template :new
      end
    end
  end
end