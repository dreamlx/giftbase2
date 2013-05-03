object @question_group
attributes :id, :name, :description, :position

child(:question_line_items) do
  extends '/api/question_line_items/index'
end
