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

if Rails.env.test? || Rails.env.cucumber?
  ::CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
else
  ::CarrierWave.configure do |config|
    config.storage :aliyun
  end
  ImageUploader
  PosterUploader
  VideoUploader
end
