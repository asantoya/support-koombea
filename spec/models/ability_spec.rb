require 'spec_helper'
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }

    context "when is an support user" do
      let(:user){ FactoryGirl.create(:support_user) }

      it{ should be_able_to(:choose_client, User) }
      it{ should be_able_to(:choose_assigned, User) }
    end
    context "when is an client user" do
      let(:user){ FactoryGirl.create(:client_user) }

      it{ should_not be_able_to(:choose_client, User) }
      it{ should_not be_able_to(:choose_assigned, User) }
    end
  end
end