# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :container do
    name { Forgery(:lorem_ipsum).sentences }
    association :owner, :factory => :user
    association :group
  end
end