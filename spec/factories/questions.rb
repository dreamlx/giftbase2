FactoryGirl.define do
  factory :question do
    # type                "Question::SingleChoice"
    sequence(:subject)  { |n| "subject #{n}"}
    hint                ""
    image               nil
    question_level_id   1
    stage_id            nil

    after(:build) do |question|
      4.times.each do
        question.single_choice_options <<  build(:single_choice_option, question: question)
      end
      question.single_choice_options.sample.update_attribute(:correct, true)
    end
  end
end