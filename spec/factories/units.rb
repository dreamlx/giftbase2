FactoryGirl.define do
  factory :unit do
    name              "this is a unit name"
    description       "this is a unit description"
    exam_minutes      60
    association       :stage
    position          10
    image             "this is a unit image"
  end
end