attributes :id, :position, :point

unless @object.nil?
	node(:question_type) { @object.question.type }

	child(:question => :question) do |question|
	  extends '/api/questions/item'
	end
end
