attributes :id, :subject, :hint, :type, :level

if @object.image?
  node(:image_url) { |question| url_with_protocol_and_host(question.image_url) }
  node(:thumb_image_url) { |question| url_with_protocol_and_host(question.image_url(:thumb)) }
end

case @object.type
when 'Question::Brief'
  child(:brief_solution) do
    attributes :id, :content
  end

when 'Question::FillInBlank'
  child(:fill_in_blank_solutions) do
    attributes :content, :position
  end

when 'Question::Matching'
  child(:matching_solutions) do
    attributes :source, :target, :hashed_source, :hashed_target
  end

when 'Question::MultipleChoice'
  child(:multiple_choice_options) do
    attributes :id, :content, :correct, :position, :sequence
  end

when 'Question::SingleChoice'
  child(:single_choice_options) do
    attributes :id, :content, :correct, :position, :sequence
  end

end
