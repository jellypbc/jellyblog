module Admin
  class PostsController < ApplicationController
    before_action :admin_only

    def index
      @posts = Post.all
        .order(id: :desc)
        .paginate(page: params[:page], per_page: 50)
    end

  end
end

