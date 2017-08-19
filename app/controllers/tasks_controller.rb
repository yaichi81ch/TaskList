class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  # def index
  #   @tasks = Task.all
  # end
  
  # def show
  # end
  
  # def new
  #   @task = Task.new
  # end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを追加しました。'
      redirect_to current_user
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの追加に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to current_user
    else
      flash.now[:danger] = 'タスクは正常に更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    
    @task.destroy
    flash[:success] = 'タスクは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def task_params
    params.require(:task).permit(:content, :duedate, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
      
    end
  end
  
end
