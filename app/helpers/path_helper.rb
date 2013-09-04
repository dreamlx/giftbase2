module PathHelper
  def url_with_protocol_and_host(url)
    if url.start_with?('http://') or url.start_with?('https://')
      url
    else
      request.protocol + request.host_with_port + url
    end
  end
end
