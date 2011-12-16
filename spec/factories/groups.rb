# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name { Forgery(:lorem_ipsum).words(10) }
    association :teacher, :factory => :user
  end
end