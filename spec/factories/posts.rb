# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :author, :factory => :user
    association :group
    content { Forgery(:lorem_ipsum).text }
  end
end