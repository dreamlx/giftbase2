attributes :id, :name, :description

child(:stages) do
  extends '/api/stages/index'
end
