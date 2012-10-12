require 'spec_helper'

describe Comment do
  it "should mark as read for user that created it" do
    comment = FactoryGirl.create(:comment)
    comment.unread?(comment.user).should == false
  end
end