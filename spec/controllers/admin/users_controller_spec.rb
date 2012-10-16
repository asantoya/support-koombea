require 'spec_helper'
include Devise::TestHelpers

describe Admin::UsersController do
	render_views
	
	before :each do
		@user = FactoryGirl.create(:admin_user)
    sign_in @user
	end

	context "#index" do
		it "should assigns users" do     
			@users = 5.times.map{ FactoryGirl.create(:client_user)}
	    get :index, {} 
			assigns(:users).sort.should eq(@users)
		end
	end

	context "#show" do
		it "should show the user" do
			@user = FactoryGirl.create(:client_user)
			get :show, { id: @user }
			assigns(:user).should eq(@user)
		end
	end

	context "#edit" do
		it "should show the user form" do
			@user = FactoryGirl.create(:client_user)
			get :edit, { id: @user }
			assigns(:user).should eq(@user)
		end
	end
end