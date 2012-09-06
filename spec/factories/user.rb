FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "test123"

    trait :support do
      role "support"
    end

    trait :client do
      role "client"
    end
  end
end