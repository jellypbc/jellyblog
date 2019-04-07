# if Rails.env.development?
#   Bullet.enable = true
#   Bullet.console = true
#   Bullet.rails_logger = true
#   Bullet.n_plus_one_query_enable = true
#   Bullet.sentry = true
#   Bullet.alert = true
#   Bullet.bullet_logger = true
#   Bullet.growl = true
#   Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
#                   :password => 'bullets_password_for_jabber',
#                   :receiver => 'your_account@jabber.org',
#                   :show_online_status => true }
#   Bullet.rails_logger = true
#   Bullet.honeybadger = true
#   Bullet.bugsnag = true
#   Bullet.airbrake = true
#   Bullet.rollbar = true
#   Bullet.add_footer = true
#   Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
#   Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware', ['my_file.rb', 'my_method'], ['my_file.rb', 16..20] ]
#   Bullet.slack = { webhook_url: 'http://some.slack.url', channel: '#defult', username: 'notifier' }
# end