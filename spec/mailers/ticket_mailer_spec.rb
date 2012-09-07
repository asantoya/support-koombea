require "spec_helper"

describe TicketMailer do
  before(:each) do
    ticket = FactoryGirl.create(:ticket)
    mail = FactoryGirl.create(:mail)
  end

  it "should have subject" do
    mail.subject.should_not be_nil
  end
end
