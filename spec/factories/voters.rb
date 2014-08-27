# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voter do
    type ""
    name "MyString"
    email "MyString"
    encrypted_password "MyString"
    reset_password_token "MyString"
    reset_password_sent_at "2014-08-26 23:03:22"
    remember_created_at "2014-08-26 23:03:22"
    sign_in_count 1
    current_sign_in_at "2014-08-26 23:03:22"
    last_sign_in_at "2014-08-26 23:03:22"
    current_sign_in_ip "MyString"
    last_sign_in_ip "MyString"
    role 1
  end
end
