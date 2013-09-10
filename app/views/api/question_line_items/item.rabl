attributes :id, :position, :point

unless @object.question.nil?
	node(:question_type) { @object.question.type }

	child(:question => :question) do |question|
	  extends '/api/questions/item'
	end
end
