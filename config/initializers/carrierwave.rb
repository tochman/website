CarrierWave.configure do |config|
config.base_path = ENV['RACK_BASE_URI']
config.storage    = :aws
config.aws_bucket = 'agileventuresstorage'
config.aws_acl    = :public_read
config.asset_host = 'https://s3-eu-west-1.amazonaws.com/agileventuresstorage'
config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

config.aws_credentials = {
    access_key_id:     'AKIAJSF632ESQTOHAHAQ',
    secret_access_key: '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'
}
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end