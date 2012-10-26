FactoryGirl.define do
  sequence :subject do |n|
    "test_#{n}"
  end

  factory :ticket do 
    subject
    description "Test description"
    status "finished"
    ticket_type "bug"
    user
  end
end