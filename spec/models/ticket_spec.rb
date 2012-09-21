require 'spec_helper'

describe Ticket, "relations" do
  it {should have_many(:comments)}
  it {should belong_to(:user)}
end

describe Ticket, "validations" do
  it "should require a username" do
    FactoryGirl.build(:ticket, subject: nil).should_not be_valid
  end
  it "should require a client" do
    FactoryGirl.build(:ticket, user_id: nil).should_not be_valid
  end
  it "should require a description" do
    FactoryGirl.build(:ticket, description: nil).should_not be_valid
  end
end
