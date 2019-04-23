class PagesController < ApplicationController  
  before_action :admin_only, only: :admin

  def index
    @no_nav = true
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
