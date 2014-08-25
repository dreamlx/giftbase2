FactoryGirl.define do
  factory :exam do
    association :unit
    association :user
    state       "placed"
  end
end