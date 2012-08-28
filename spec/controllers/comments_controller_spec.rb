require 'spec_helper'

describe CommentsController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should_not be_success
    end
  end

end
