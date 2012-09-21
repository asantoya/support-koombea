require 'spec_helper'

describe "tickets/show" do
  include Devise::TestHelpers
  before(:each) do
    @ticket = FactoryGirl.create(:ticket)
    @user = FactoryGirl.create(:support_user)
    sign_in @user
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@ticket.subject)
    rendered.should match(@ticket.description)
  end
end
