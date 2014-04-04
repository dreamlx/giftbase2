attributes :id, :name, :description, :exam_minutes

node(:lock_state){ |unit| unit.lock_state }

child(:user) { attributes :id, :email }

child(:map_places) do
  extends '/api/map_places/index'
end
