# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name { Forgery(:name).company_name }
    description { Forgery(:lorem_ipsum).sentences }
    association :group
    association :leader, :factory => :user
  end
end