require 'spec_helper'

describe TicketsController do

  include Devise::TestHelpers

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all tickets as @tickets" do
      ticket = FactoryGirl.create(:ticket)
      get :index, {}
      assigns(:tickets).should eq([ticket])
    end
  end

end
