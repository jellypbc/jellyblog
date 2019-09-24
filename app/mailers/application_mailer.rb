class ApplicationMailer < ActionMailer::Base
	include AutoLogin
	
  default from: 'founders@jellypbc.com'
  layout 'mailer'
end
