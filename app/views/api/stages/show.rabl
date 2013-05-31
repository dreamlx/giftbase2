object @stage
attributes :id, :name, :description, :price
child(:units) do
  extends '/api/units/index'
end
