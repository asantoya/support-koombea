FactoryGirl.define do
  factory :document do 
    comment

    trait :img do
      document { File.open(File.join(Rails.root, 'public', 'test', 'colombia.jpeg')) }
    end

    trait :xls do
      document { File.open(File.join(Rails.root, 'public', 'test', 'colombia.xls')) }
    end

    trait :doc do
      document { File.open(File.join(Rails.root, 'public', 'test', 'colombia.doc')) }
    end

    trait :pdf do
      document { File.open(File.join(Rails.root, 'public', 'test', 'colombia.pdf')) }
    end

    trait :mul do
      document { File.open(File.join(Rails.root, 'public', 'test', 'colombia.ppt')) }
    end

    factory :img_document, traits: [:img]
    factory :xls_document, traits: [:xls]
    factory :doc_document, traits: [:doc]
    factory :pdf_document, traits: [:pdf]
    factory :mul_document, traits: [:mul]
  end
end