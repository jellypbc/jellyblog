module AutoLogin
  extend ActiveSupport::Concern

  included do
    helper_method :auto_login
  end

  def auto_login(link, user, expires_at = nil)
    # expiry defaults to 1 week, see EmailToken

    host = Rails.application.routes.default_url_options[:host].sub(/www\./i, '')

    if link =~ /#{host}/i
      token = email_token(user, expires_at).token
      link.sub /^(https?:\/\/(www\.)?#{host}\/)(.*)/i, "\\1et/#{token}/\\3"
    else
      link
    end
  end

  private

    def email_token(user, expires_at)
      @email_token ||= EmailToken.create user: user, expires_at: expires_at
    end
end
