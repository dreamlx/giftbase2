attributes :id, :point, :comment, :reviewed_at

%w(option_id option_ids content contents matches).each do |attr|
  if @object.send(attr)
    attributes attr.to_sym
  end
end

if @object.image?
  node(:image_url) { |answer| url_with_protocol_and_host(answer.image_url) }
  node(:thumb_image_url) { |answer| url_with_protocol_and_host(answer.image_url(:thumb)) }
end

child(:question_line_item) do
  extends '/api/question_line_items/item'
end

if @object.option_id
  attributes :option_id
end
