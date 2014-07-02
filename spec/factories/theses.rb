# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :thesis do
    issue nil
    summary "MyText"
    text "MyText"
    author nil
  end
end
