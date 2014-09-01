# require 'faker'
FactoryGirl.define do
  factory :single_choice_option do
    association         :question
    content             "Faker::Lorem.sentence"
    sequence(:position) { |n| n + 1}
    # sequence            nil
    correct             false
    image               nil
  end
end