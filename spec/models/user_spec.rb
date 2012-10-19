require 'spec_helper'

describe "find_for_google_apps" do
    before do
      @auth = {
        provider: "google_apps",
        uid: "http://koombea.com/openid?id=103063742222819161132",
        info: {
          email: "jose.gomez@koombea.com",
          name: "Jose Gomez"
        }.stringify_keys
      }.stringify_keys
    end

    it "should instantiate a new user if it doesn't already exist" do
      User.find_for_google_apps(@auth).should be_new_record
    end

    it "should assign auth's attributes to new user" do
      @user = User.find_for_google_apps(@auth)
      info = @auth["info"]
      @user.email.should eql(info["email"])
    end

    it "should not create a new user if it is found on the database, by email" do
      @user = FactoryGirl.create(:support_user, email: @auth["info"]["email"])
      expect {
        User.find_for_google_apps(@auth)
      }.not_to change(User, :count)
    end

    it "should return the existing user if it already exists" do
      @user = FactoryGirl.create(:support_user, email: @auth["info"]["email"])
      User.find_for_google_apps(@auth).should eql(@user)
    end
end

describe User do
  it "return name" do
    user = FactoryGirl.build(:user)
    user.display_name.should eq(user.name)
  end
end
