FactoryGirl.define do
  factory :thesis do
    summary "MyText"
    text "MyText"
    association :author, factory: :user
  end
end
