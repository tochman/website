CarrierWave.configure do |config|
  config.storage = :dropbox
  config.root = Rails.root.join('tmp')
  config.dropbox_app_key = "chjxxbhpojosbt3"
  config.dropbox_app_secret = "wlton1e4b7zwc7o"
  config.dropbox_access_token = "t9iznd2jdniaob89"
  config.dropbox_access_token_secret = "fj8m1eg7u3v89zg"
  config.dropbox_user_id = "52190197"
  config.dropbox_access_type = "app_folder"
end