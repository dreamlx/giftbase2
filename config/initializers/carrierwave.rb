CarrierWave.configure do |config|
  config.storage = :aliyun
  config.aliyun_access_id = 'Ev9TuOn9iXVT3WWL'
  config.aliyun_access_key = 'MSdy0ScnTZFqZbMWChknGJl8XAxfMq'
  config.aliyun_bucket = 'giftbase'

  # true - access from LAN, false - access from WAN
  config.aliyun_internal = false

  # Custom domain to you_bucket_name.oss.aliyuncs.com
  config.aliyun_host = "giftbase.oss.aliyuncs.com" 

  #test
end
