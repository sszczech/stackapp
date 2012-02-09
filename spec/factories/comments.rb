FactoryGirl.define do
  factory :comment do
    content { Forgery(:lorem_ipsum).sentences }
    association :author, :factory => :user

  end
end