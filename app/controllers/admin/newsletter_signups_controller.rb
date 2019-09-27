module Admin
  class NewsletterSignupsController < ApplicationController
    before_action :admin_only

    def index
      @newsletter_signups = NewsletterSignup.all
        .order(id: :desc)
        .paginate(page: params[:page], per_page: 50)
    end

  end
end

