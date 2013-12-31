class Contact < MailForm::Base
  attribute :name
  attribute :email
  attribute :message
  attribute :nickname,  :captcha  => true

  validates :message, :presence => true,
            :length => { :minimum => 5, :maximum => 500 }

  validates :name, :presence => true,
            :length => { :minimum => 3, :maximum => 25 }

  validates :email, :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                         :multiline => true },
            :length => { :minimum => 5,
                         :maximum => 50 }

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => "Message from WebsiteOne",
        :to => "thomas@nocebo.se",
        :from => %("#{name}" <#{email}>)
    }
  end
end