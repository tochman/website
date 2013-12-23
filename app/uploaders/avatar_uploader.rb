# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
include CarrierWave::MiniMagick

  storage :dropbox
  process :resize_to_fit => [150, 150]
  version :mini do
    process resize_to_fit: [25, 25]
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
     "/images/" + [version_name, "anonymous.jpg"].compact.join('_')
  end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

  def filename
     "avatar-#{model.id}.jpg" if original_filename
  end
end