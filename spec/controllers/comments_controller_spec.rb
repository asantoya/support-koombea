require 'spec_helper'
include Devise::TestHelpers

describe CommentsController do

  describe "#create" do
    before :each do
      @user = FactoryGirl.create(:client_user)
      sign_in @user
      @ticket = FactoryGirl.create(:ticket)
    end
    it "should save comment" do
      attrs = FactoryGirl.attributes_for(:comment)
      expect{
        post :create, {ticket_id: @ticket.id, comment: attrs}
      }.to change{Comment.count}.by(1)
    end
    it "should not save comment" do
      attrs = FactoryGirl.attributes_for(:comment, body: "")
      expect{
        post :create, {ticket_id: @ticket.id, comment: attrs}
      }.to change{Comment.count}.by(0)
    end
  end

  describe "mark_read_comments" do
    before :each do
      @user = FactoryGirl.create(:client_user)
      sign_in @user
      @ticket = FactoryGirl.create(:ticket)
    end
    it "should mark read comment" do
      comment = FactoryGirl.create(:comment, user: @user, ticket: @ticket)
      get :mark_read_comments, { ticket_id: @ticket.id, comment: comment }
      comment.unread?(@user).should == false
    end
  end

end
