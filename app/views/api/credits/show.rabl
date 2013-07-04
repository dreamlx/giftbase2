object @credit

attributes :id, :balance

child(:credit_line_items) do
  extends '/api/credit_line_items/index'
end
