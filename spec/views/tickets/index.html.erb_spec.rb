require 'spec_helper'

describe "tickets/index" do
  before(:each) do
    @ticket = FactoryGirl.create(:ticket)
  end

  it "renders a list of tickets" do
        
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@ticket.subject)
    rendered.should match(@ticket.description)

  end

end
