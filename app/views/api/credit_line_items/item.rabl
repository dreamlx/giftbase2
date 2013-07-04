attributes :id, :amount

if @object.order
  child(:order) do
    extends '/api/orders/item'
  end
end

if @object.stage
  child(:stage) do
    extends '/api/stages/item'
  end
end
