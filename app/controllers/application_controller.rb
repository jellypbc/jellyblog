require "turbolinks/redirection"

class ApplicationController < ActionController::Base
  include Turbolinks::Redirection
  protect_from_forgery
  include SessionsHelper

  def admin_only
    unless user_is_admin?
      respond_to do |format|
        format.html {
          redirect_to root_path,
          notice: "These are not the droids you are looking for."
         }
        format.json {
          head :unauthorized
         }
      end
    end
  end
end
