FactoryGirl.define do
  factory :answer do
    association     :exam
    association     :question_line_item
    data            "this is an answer data"
    point           95.5
    comment         "this is an answer comment"
    image           "this is an answer image"
  end
end