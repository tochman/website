FactoryGirl.define do 
  factory :booking do
    association :subject

    start_time  { DateTime.now + 30.minutes }
    end_time    { DateTime.now + 5.minutes }
    length      10
    description 'This is booking'
    url         'www.example.com'
  end
end