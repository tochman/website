# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "MyString"
    body "MyText"
    created "2013-12-01"
    public false
  end
end
