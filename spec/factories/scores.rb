FactoryGirl.define do
  factory :score do
    association     :user
    number          {rand(0..100)}
  end
end