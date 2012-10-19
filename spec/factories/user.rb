FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  sequence :name do |n|
    "Name_#{n}"
  end

  factory :user do
    name
    email
    password "test123"
    receives_notifications true
    role "support"
  
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