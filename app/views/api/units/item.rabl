attributes :id, :name, :description, :exam_minutes

child(:user) { attributes :id, :email }

child(:question_groups) do
  extends '/api/question_groups/index'
end
