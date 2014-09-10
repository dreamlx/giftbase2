FactoryGirl.define do
  factory :score do
    association     :user
    number          35.6
  end
end