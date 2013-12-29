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

  describe 'DELETE #destroy' do
    before :each do
      @subject = create(:subject)
      @controller.stub(:authenticate_user!).and_return(true)
    end

    it "deletes the subject" do
      expect {
        delete :destroy, id: @subject
      }.to change(Subject, :count).by(-1)
    end

    it "redirects to subjects#index" do
      delete :destroy, id: @subject
      expect(response).to redirect_to subjects_path
    end
  end

  describe 'GET #edit' do
    before :each do
      @subject = create(:subject)
      @controller.stub(:authenticate_user!).and_return(true)
    end

    it "assigns the requested subject to @subject" do
      get :edit, id: @subject
      expect(assigns(:subject)).to eq @subject
    end

    it "renders the :edit template" do
      get :edit, id: @subject
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before :each do 
      @subject = create(:subject, name: 'Rails', description: 'Web Framework')
      @controller.stub(:authenticate_user!).and_return(true)
    end

    context 'with valid attributes' do
      it "located the requested @subject" do
        patch :update, id: @subject, subject: attributes_for(:subject)
        expect(assigns(:subject)).to eq @subject
      end

      it "changes @subject's attributes" do
        patch :update, id: @subject,
          subject: attributes_for(:subject,
            name: 'Updated', description: 'Web Framework')
        @subject.reload
        expect(@subject.name).to eq 'Updated'
        expect(@subject.description).to eq 'Web Framework'
      end

      it 'redirects to the updated subject' do
        patch :update, id: @subject, subject: attributes_for(:subject)
        expect(response).to redirect_to @subject
      end
    end

    context 'with invalid attributes' do
      it "does not change the subject's attributes" do 
        patch :update, id: @subject,
          subject: attributes_for(:subject,
            name: nil, description: 'New')
        @subject.reload
        expect(@subject.name).to eq 'Rails'
        expect(@subject.name).to_not eq 'New'
      end

      it 're-renders the #edit template' do
        patch :update, id: @subject,
          subject: attributes_for(:invalid_subject)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET #show' do
    before :each do 
      @subject = create(:subject)
    end
    
    it 'assigns the requested subject to @subject' do
      get :show, id: @subject
      expect(assigns(:subject)).to eq @subject
    end

    it 'renders the :show template' do
      get :show, id: @subject
      expect(response).to render_template :show
    end
  end
end