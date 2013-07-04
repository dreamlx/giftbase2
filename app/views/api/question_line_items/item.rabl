attributes :id, :position, :point

node(:question_type) { @object.question.type }

child(:question => :question) do |question|
  extends '/api/questions/item'
end
