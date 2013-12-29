FactoryGirl.define do
  factory :subject do
    name 'John'
    description 'This is the subject'
    group_url 'www.example.com'

    factory :invalid_subject do
      name nil
    end
  end
end