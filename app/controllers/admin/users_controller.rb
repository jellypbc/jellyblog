module Admin
  class UsersController < ApplicationController
    before_action :admin_only

    def index
      @users = User.all
        .order(id: :desc)
        .paginate(page: params[:page], per_page: 50)
    end

  end
end

