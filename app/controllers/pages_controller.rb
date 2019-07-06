class PagesController < ApplicationController  
  before_action :admin_only, only: :admin
  before_action :authenticate!, only: [:dashboard]



  def index
    @no_nav = true
  end

  def dashboard
    @projects = current_user.projects
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

  
end
