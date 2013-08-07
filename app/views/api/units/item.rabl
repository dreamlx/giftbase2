attributes :id, :name, :description, :exam_minutes

child(:user) { attributes :id, :email }

child(:question_groups) do
  extends '/api/question_groups/index'
end

child(:map_places) do
  extends '/api/map_places/index'
end
