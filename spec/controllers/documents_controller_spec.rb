require 'spec_helper'

describe DocumentsController do
  before (:each) do
    @document = FactoryGirl.create(:document)
  end

  describe "GET 'show'" do

    it "should be successful" do
      get :show, :id => @document.id
      response.should be_success
    end

    it "should find the right document" do
      get :show, :id => @document.id
      assigns(:document).should == @document
    end

  end


end
