attributes :id, :name, :description

child(:stages) do
  extends '/api/stages/index'
end

child(:pictures) do
  extends '/api/pictures/index'
end
