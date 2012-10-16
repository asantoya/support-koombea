require 'spec_helper'
include Devise::TestHelpers

describe Admin::AdminUsersController do
	render_views
	
	before :each do
		@user = FactoryGirl.create(:admin_user)
    sign_in @user
	end

	context "#index" do
		it "should assigns admin_users" do     
			@users = 5.times.map{ FactoryGirl.create(:admin_user)}
	    get :index, {} 
			assigns(:admin_users).size.should > 0 
		end
	end

	context "#show" do
		it "should show the user" do
			@user = FactoryGirl.create(:admin_user)
			get :show, { id: @user }
			assigns(:admin_user).should eq(@user)
		end
	end

	context "#edit" do
		it "should show the user form" do
			@user = FactoryGirl.create(:admin_user)
			get :edit, { id: @user }
			assigns(:admin_user).should eq(@user)
		end
	end
end