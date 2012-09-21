FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "test123"
    receives_notifications true
  
    trait :support do
      role "support"
    end

    trait :client do
      role "client"
    end

    factory :client_user, traits: [:client]
    factory :support_user, traits: [:support]
  end
end