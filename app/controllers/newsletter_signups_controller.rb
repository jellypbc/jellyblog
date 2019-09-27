class NewsletterSignupsController < ApplicationController

	def create
    @newsletter_signup = NewsletterSignup.new(newsletter_params)
    if @newsletter_signup.save
      redirect_to root_path, notice: "Thanks! You'll receive a Slack invite shortly, and now you can comment on blog posts too. ✨"
    else
      msg = @newsletter_signup.errors.messages.map{|m| m[1] }.join(", ")
      redirect_back(fallback_location: root_path, notice: "Oops, there was an error: #{msg}")
    end

	end

	def update
	end

	def destroy
	end

	private
		def newsletter_params
			params.require(:newsletter_signup).permit( :email )
		end
end
