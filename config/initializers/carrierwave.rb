#CarrierWave.configure do |config|
#  config.dropbox_app_key = 'chjxxbhpojosbt3'
#  config.dropbox_app_secret = 'wlton1e4b7zwc7o'
#  config.dropbox_access_token = 't9iznd2jdniaob89'
#  config.dropbox_access_token_secret = 'fj8m1eg7u3v89zg'
#  config.dropbox_user_id = '52190197'
#  config.dropbox_access_type = 'app_folder'
#end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end