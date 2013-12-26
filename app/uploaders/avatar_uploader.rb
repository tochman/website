# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
include CarrierWave::MiniMagick

  storage :dropbox
  process :resize_to_fit => [150, 150]
  version :mini do
    process resize_to_fit: [25, 25]
  end


  def store_dir
    Rails.env.production? ? (primary_folder = "production") : (primary_folder = "test")
    "#{primary_folder}/uploads/images/#{model.id}"
  end


  def default_url
    'app/assets/images/anonymous.jpg'
  end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

  def filename
     "avatar-#{model.id}.jpg" if original_filename
  end
end