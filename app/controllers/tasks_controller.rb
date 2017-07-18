class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクの追加に成功しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])  
  end
  
  def update
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'タスクは正常に更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    if @task.destroy
      flash[:success] = 'タスクは正常に削除されました'
      redirect_to task_url
    end
    
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content)
  end
end