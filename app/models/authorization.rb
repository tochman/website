class Authorization < ActiveRecord::Base
  belongs_to :user

  after_create :fetch_details



  def fetch_details
    self.send("fetch_details_from_#{self.provider.downcase}")
  end


  def fetch_details_from_facebook
    graph = Koala::Facebook::API.new(self.token)
    facebook_data = graph.get_object("me")
    self.username = facebook_data['username']
    self.save
    self.user.username = facebook_data['username'] if self.user.username.blank?
    self.user.first_name = facebook_data['first_name'] #if self.user.first_name.blank?
    self.user.last_name = facebook_data['last_name'] #if self.user.last_name.blank?
    self.user.remote_avatar_url = "http://graph.facebook.com/" + self.username + "/picture?type=large" if self.user.avatar.blank?
    self.user.location = facebook_data['location'].values.second.to_s if self.user.location.blank?
    self.user.save
  end

  def fetch_details_from_twitter
    twitter_object = Twitter::Client.new(
        :oauth_token => self.token,
        :oauth_token_secret => self.secret
    )
    twitter_data = Twitter.user(self.uid.to_i)
    self.username = twitter_data.username
    self.save
    self.user.username = twitter_data.username if self.user.username.blank?
    self.user.remote_image_url = twitter_data.profile_image_url if self.user.avatar.blank?
    self.user.location = twitter_data.location if self.user.location.blank?
    self.user.save(:validate => false)
  end


  def fetch_details_from_github
    github_data = OmniAuth::Strategies::GitHub.new({})
    self.user.remote_avatar_url = github_data.avatar_url
    self.user.save(:validate => false)
  end

  def fetch_details_from_google_oauth2

  end

end