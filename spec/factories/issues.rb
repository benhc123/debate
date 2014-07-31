FactoryGirl.define do
  factory :issue do
    title "MyText"
    text "MyText"
    association :author, factory: :user
  end
end
