require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do
  context "gravatar" do
  	it "should show img" do
  		user = FactoryGirl.create(:support_user)
  		default_url = "#{root_url}assets/img.png"
    	gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
  		helper.avatar_url(user).should eq("http://gravatar.com/avatar/#{gravatar_id}.png?d=#{CGI.escape(default_url)}")
  	end
  end

  it "markdown" do
  	helper.markdown("Some Text")
  end

end
