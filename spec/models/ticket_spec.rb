require 'spec_helper'

describe Ticket do
  context "relations" do
    it {should have_many(:comments)}
    it {should belong_to(:user)}
    it {should belong_to(:assigned_to)}
  end

  context "validations" do
    it "should require a subject" do
      FactoryGirl.build(:ticket, subject: nil).should_not be_valid
    end
    it "should require a client" do
      FactoryGirl.build(:ticket, user_id: nil).should_not be_valid
    end
    it "should require a description" do
      FactoryGirl.build(:ticket, description: nil).should_not be_valid
    end
    it "should require a ticket_type" do
      FactoryGirl.build(:ticket, ticket_type: nil).should_not be_valid
    end
  end

  it "return subject" do
    ticket = FactoryGirl.build(:ticket)
    ticket.display_name.should eq(ticket.subject)
  end

  it "returns a sorted array of results that match" do

    ticket = FactoryGirl.create(:ticket, status: "in_process")
    ticket1 = FactoryGirl.create(:ticket, status: "finished")
    ticket2 = FactoryGirl.create(:ticket, status: "finished")

    Ticket.search(nil, nil, "finished").sort.should == [ticket1, ticket2]
  end
end