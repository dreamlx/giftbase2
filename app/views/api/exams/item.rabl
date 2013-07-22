attributes :id, :started_at, :stopped_at, :state

child(:unit) do
  extends '/api/units/item'
end

child(:answers) do
  extends '/api/answers/index'
end
