class UsersController < ApplicationController
  before_action :fetch_user, only: [
    :show, :edit, :update, :destroy, :delete_image_attachment, :drafts
  ]
  before_action :authenticate!, only: [:drafts]
  before_action :check_if_signed_in, only: [:new]
  before_action :admin_only, only: [:index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to after_sign_in_path, notice: "Welcome to Research Pizza, thank you for signing up!"
    else
      msg = @user.errors.messages.map{|m| m[1] }.join(", ")
      redirect_back(fallback_location: root_path, notice: "Oops, there was an error: #{msg}")
    end
  end

  def show
  end

  def drafts
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
    if current_user
      @user = current_user

    elsif !correct_user?(@user)
      redirect_to root_path, notice: "Oops, you can't view that page."
    end

  end

  def update
    respond_to do |format|
      if @user.update(user_params)

        @user.avatar.attach(user_params[:avatar])

        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @user.avatar.purge_later
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'Image was successfully destroyed.' }
    end
  end

  def reset_password
    flash[:notice] = "You're in. Please change your password for next time!"
    redirect_to edit_user_path(current_user, anchor: 'password')
  end

  private

    def fetch_user
      @user ||= begin
        User.find_by_username(params[:id] || params[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          # If admin, attempt to lookup by id
          if user_is_admin?
            User.find params[:id]
          else
            raise e
          end
        end
    end

    def correct_user?(user)
      return user if current_user?(user) || current_user.admin?
    end

    def user_is_admin?
      current_user && current_user.admin?
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password, :username, :avatar
      ).to_h
    end

end
