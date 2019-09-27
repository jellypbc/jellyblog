class SlackInviter

	CHANNELS = [
    'CNG313A6L', # general
    'CNNGS9C00' # introduce-yourself
  ]

	def self.send_slack_invite(email)
	  if ENV['SLACK_TOKEN']
      invite_uri = URI.parse 'https://jelly-community.slack.com/api/users.admin.invite'

      begin
	      response = Net::HTTP.post_form(invite_uri, {
	        email: email,
	        channels: CHANNELS, 
	        token: ENV['SLACK_TOKEN']
	      })
	      json_response = JSON.parse response.body

	      did_it_work = json_response["ok"] ? "Success" : json_response["error"].titleize
	      self.notify_slack_inviter_chan(did_it_work, email)

      rescue => e
        error = e
      end
    else
      puts "Hmm whatchya doin?"
    end
  end

  def self.notify_slack_inviter_chan(did_it_work, email)
    hook_url = URI.parse ENV['SLACK_INVITER_HOOK_URL']
    msg = "#{did_it_work}: Email: #{email}"

    begin
      response = Net::HTTP.post_form(hook_url, {
      	payload: { text: msg }.to_json 
      })
    rescue => e
    	error = e
    end
  end

end
