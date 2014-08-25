FactoryGirl.define do
  factory :user_unit do
    association       :user
    association       :unit
    state             "lock"
  end
end