FactoryGirl.define do
  factory :stage do
    name              "this is a stage name"
    description       "this is a stage description"
    price             10.1
    video             "this is a stage video"
    association       :grade
    video_poster      "this is a stage video poster"
    position          10
  end
end