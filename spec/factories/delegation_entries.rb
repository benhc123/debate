# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delegation_entry do
    delegation nil
    delegate_type "MyString"
    delegate_id 1
    position 1
  end
end
