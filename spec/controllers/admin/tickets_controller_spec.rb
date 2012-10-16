require 'spec_helper'
include Devise::TestHelpers

describe Admin::TicketsController do
	render_views
	
	before :each do
		@user = FactoryGirl.create(:admin_user)
    sign_in @user
	end

	context "#index" do
		it "should assigns ticket" do     
			@tickets = 5.times.map{ FactoryGirl.create(:ticket)}
	    get :index, {} 
			assigns(:tickets).sort.should eq(@tickets)
		end
	end

	context "#show" do
		it "should show the ticket" do
			@ticket = FactoryGirl.create(:ticket)
			get :show, { id: @ticket }
			assigns(:ticket).should eq(@ticket)
		end
	end

	context "#edit" do
		it "should show the ticket form" do
			@ticket = FactoryGirl.create(:ticket)
			get :edit, { id: @ticket }
			assigns(:ticket).should eq(@ticket)
		end
	end
end