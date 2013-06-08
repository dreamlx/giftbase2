module PathHelper
  def url_with_protocol_and_host(url)
    request.protocol + request.host_with_port + url
  end
end
