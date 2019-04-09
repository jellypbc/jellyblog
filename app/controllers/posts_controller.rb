class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :set_form_user, only: [:create]
  before_action :authenticate!, except: [:show]

  def index
    @posts = current_user.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
  
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save!
        # @post.set_slug!
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: {redirect_to: post_path(@post) } }
        # format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find_by_id_or_slug params[:id] || params[:post_id]
      raise ActiveRecord::RecordNotFound unless @post
    end

    def set_form_user
      begin
        if (user_id = params[:post][:user_id]) && user_id.present?
          @user = User.find(user_id)
        elsif (user_params.any?)
          if @user = User.find_by_email(user_params[:email])
          else
            @user = User.create!(
              user_params.merge({password: 'experiment'})
            )
          end
        elsif current_user
          @user = current_user
        end
        
      rescue => e
        render(json: { error: "No user" }, status: :unprocessable_entity) and return
      end
    end


    def post_params
      params.require(:post).permit(
        :title, :description, :public, :body_json, :body
      ).to_h
    end
end
