class UserUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
=begin
  storage :file
  # storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
=end
end
