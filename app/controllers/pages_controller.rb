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

  def slack
  end
  
end
