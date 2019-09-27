class PagesController < ApplicationController  
  before_action :admin_only, only: :admin
  before_action :authenticate!, only: [:dashboard]

  def index
    @no_nav = true

    @posts = Post.are_public
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 4)
  end

  def dashboard
    @posts = current_user.posts
  end

  def about
  end

  def terms
  end

  def privacy
  end

  def admin
  end

  def follow
    @no_newsletter = true

    @newsletter_signup = NewsletterSignup.new
  end

  def slack_invite
    email = params[:slack_invite][:email]
    
    if SlackInviter.send_slack_invite(email)
      redirect_to after_sign_in_path, notice: "Thanks! You'll receive a Slack invite shortly, and now you can comment on blog posts too. ✨"
    end

  end
  
end
