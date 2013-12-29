# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick


  process :resize_to_fit => [150, 150]
  process :gif_to_jpg_convert
  process :convert => 'jpg'
  version :mini do
    process resize_to_fit: [25, 25]
  end
  storage :dropbox

  def gif_to_jpg_convert
    image = MiniMagick::Image.open(current_path)
    if image.to_s.include?(".gif") do
      image.collapse! #get first gif frame
      image.format "jpg"
      File.write("public/#{store_dir}/gif_preview.jpg", "") #"touch" file
      image.write "public/#{store_dir}/gif_preview.jpg"
    end
    end
  end

  def store_dir
    Rails.env.production? ? (primary_folder = "production") : (primary_folder = "test")
    #"#{primary_folder}/uploads/images/#{model.id}"
    "/#{primary_folder}/#{model.class.to_s.underscore}/#{model.id}"

  end

  #def url(*args)
  #  super_url = super
  #  File.exists?(root + super_url) ? super_url : default_url
  #end


  def default_url
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "anonymous_avatar.gif"].compact.join('_'))

    'anonymous_avatar.gif'
    #"/images/" + [version_name, "anonymous.jpg"].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "avatar-#{model.id}.jpg" if original_filename
  end

end
