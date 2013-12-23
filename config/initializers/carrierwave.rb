CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["APP_KEY"]
  config.dropbox_app_secret = ENV["APP_SECRET"]
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.dropbox_access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  config.dropbox_user_id = ENV["USER_ID"]
  config.dropbox_access_type = "app_folder"
  debugger
end



#CarrierWave.configure do |config|
#  config.dropbox_app_key = ENV["chjxxbhpojosbt3"]
#  config.dropbox_app_secret = ENV["wlton1e4b7zwc7o"]
#  config.dropbox_access_token = ENV["t9iznd2jdniaob89"]
#  config.dropbox_access_token_secret = ENV["fj8m1eg7u3v89zg"]
#  config.dropbox_user_id = ENV["52190197"]
#  config.dropbox_access_type = ENV["app_folder"]
#end