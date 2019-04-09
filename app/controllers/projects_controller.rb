class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:show]

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save!
        @project.users << current_user
        format.html { redirect_to @project, notice: 'project was successfully created.' }
        format.json { render json: {redirect_to: project_path(@project) } }
        # format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find params[:id] || params[:project_id]
      raise ActiveRecord::RecordNotFound unless @project
    end

    def set_form_user
      begin
        if (user_id = params[:project][:user_id]) && user_id.present?
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


    def project_params
      params.require(:project).permit(
        :title, :description, :public, :body_json, :body
      ).to_h
    end
end
