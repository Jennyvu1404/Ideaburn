Cloudinary.config do |config|
  config.cloud_name = Settings.cloudinary.cloud_name
  config.api_key = Settings.cloudinary.api_key
  config.api_secret = Settings.cloudinary.api_secret
  config.cdn_subdomain = true
end
