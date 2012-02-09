FactoryGirl.define do
  factory :user do
    email { Forgery(:internet).email_address }
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
    password { 'password' }
    password_confirmation { 'password' }
  end
end