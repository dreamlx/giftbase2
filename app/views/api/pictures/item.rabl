attributes :id, :name, :version

if @object.image?
  node(:image_url) { |stage| url_with_protocol_and_host(stage.image_url) }
  node(:thumb_image_url) { |stage| url_with_protocol_and_host(stage.image_url(:thumb)) }
end
