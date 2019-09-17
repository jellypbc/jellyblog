class CommentsController < ApplicationController
  before_action :admin_only, only: :index
  before_action :load_commentable, only: :show
  before_action :find_comment, only: :destroy

  def index
    @comments = Comment.all
  end

  def new
  end

  def create
    @comment = @commentable.comments
      .by_user(current_user)
      .new(comment_params)

    if @comment.save
      redirect_to @commentable, notice: 'Comment created'
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.commentable, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private

    def comment_params
      params.require(:comment)
        .permit(
          :content, :commentable_type, :commentable_id,
          :user_id, :data_key )
        .to_h
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def load_commentable
      resource, id = request.path.split('/')[1,2]
      klass = resource.singularize.classify.constantize

      if klass == Post
        @commentable = klass.find_by_id_or_slug(id)
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    # from experiment
    def find_target
      klass = comment_params[:commentable_type].constantize
      @target = klass.find comment_params[:commentable_id]
    end

    # from experiment
    def find_parent
      @parent = if comment_params[:parent_id].present?
        Comment.find comment_params[:parent_id]
      end
    end

end
