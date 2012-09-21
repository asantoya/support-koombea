require 'spec_helper'

describe "tickets/new" do

  include Devise::TestHelpers

  before(:each) do
    @ticket = Ticket.new
    @clients = User.where(role: "client")
    @assigned = User.where(role: "support")
    @user = FactoryGirl.create(:support_user)
    sign_in @user
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
      assert_select "input#ticket_subject", :name => "ticket[subject]"
      assert_select "textarea#ticket_description", :name => "ticket[description]"
    end
  end
end
