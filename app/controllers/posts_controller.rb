class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :set_form_user, only: [:create]
  before_action :authenticate!, except: [:show]

  def index
    @posts = Post.all
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 10)
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

    if @post.save!
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: {redirect_to: post_path(@post) } }
      end
    else
      respond_to do |format|
        format.html { render :new }
        # format.js { render json: {dog: "dog"}}
        # format.js { render status: :bad_request, json: { responseText: @post.errors.full_messages.first } }
        format.json { render @post.errors.messages.to_json }
      end
    end
  end

  def update

    respond_to do |format|
      if @post.update!(post_params)
        post = Post.find @post.id

        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render json: { redirect_to: post_path(post) } }
      else
        format.html { render :edit }
        format.json { render json: @post.errors.messages.to_json }
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
      id_or_slug = params[:id] || params[:post_id]

      @post ||= begin
        Post.find_by!(slug: id_or_slug)
      rescue
        if (post = Post.find id_or_slug)
          post
        else
          raise ActiveRecord::RecordNotFound
        end
      end
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
        :title, :description, :public, :body_json, :body, :content
      ).to_h
    end
end
