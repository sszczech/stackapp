# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stream do
    id Time.now.to_i
    message { Forgery(:lorem_ipsum).text }
    created_at Time.now
    url { Forgery(:internet).domain_name }
  end
end