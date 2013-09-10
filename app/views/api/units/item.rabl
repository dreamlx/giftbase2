attributes :id, :name, :description, :exam_minutes

child(:user) { attributes :id, :email }

child(:map_places) do
  extends '/api/map_places/index'
end
