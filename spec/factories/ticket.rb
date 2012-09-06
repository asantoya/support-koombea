FactoryGirl.define do
  sequence :subject do |n|
    "test_#{n}"
  end

  factory :ticket do 
    subject
    description "Test description"
    status "Ended"
    ticket_type "Bug"
    user
  end
end