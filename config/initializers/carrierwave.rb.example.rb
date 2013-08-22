CarrierWave.configure do |config|
  config.storage = :aliyun
  config.aliyun_access_id = 'xxxxxx'
  config.aliyun_access_key = 'xxxxxx'
  config.aliyun_bucket = 'xxxxxx'

  # true - access from LAN, false - access from WAN
  config.aliyun_internal = false

  # Custom domain to you_bucket_name.oss.aliyuncs.com
  # config.aliyun_host = "foo.bar.com" 
end
