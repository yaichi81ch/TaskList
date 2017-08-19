class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.page(params[:page])
    counts(@user)
    @users = User.all.page(params[:page])
    @task = @user.tasks.new
  end

  def new
    @user = User.new
    # @task = @user.task.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザを登録できませんでした'
      render :new
    end
      
    @task = @user.tasks.new
    
    if @task.save
      flash[:success] = 'タスクを追加しました'
      
    else
      flash.now[:danger] = 'タスクを追加できませんでした'
      
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
