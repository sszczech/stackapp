# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_group do
    association :user
    association :group
  end
end