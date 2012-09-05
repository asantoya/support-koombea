require 'spec_helper'

describe Ticket, "relations" do
  it {should have_many(:comments)}
  it {should belong_to(:user)}
end

describe Ticket, "validations" do

  it {should validate_presence_of(:subject)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:ticket_type)}
  it {should validate_presence_of(:user_id)}
end
