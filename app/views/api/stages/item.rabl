attributes :id, :name, :description, :price, :position

if @object.video?
  node(:video_url) { |stage| url_with_protocol_and_host(stage.video_url) }
end

if @object.video_poster?
  node(:video_poster_url) { |stage| url_with_protocol_and_host(stage.video_poster_url) }
  node(:thumb_video_poster_url) { |stage| url_with_protocol_and_host(stage.video_poster_url(:thumb)) }
end

node(:purchase_state){ |state| @object.purchase?(current_user) ? "paid" : 'unpaid' }


child(:units) do
  extends '/api/units/index'
end

child(:map_places) do
  extends '/api/map_places/index'
end
