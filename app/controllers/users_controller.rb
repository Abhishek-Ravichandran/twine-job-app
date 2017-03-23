class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :allow, :remove]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @jobs = Job.paginate(page: params[:page])
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Jobs App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def allow
    @user = User.find(params[:user_id])
    if not @user.job_ids.include? params[:job_id] then
      flash[:success] = "Job Added"
      @job = Job.find(params[:job_id])
      @user.jobs << @job
    end
    redirect_to @user
  end
  
  def remove
    @user = User.find(params[:user_id])
    @job = Job.find(params[:job_id])
    if @user.jobs.include? @job then
      flash[:success] = "Job Removed"
      @job = Job.find(params[:job_id])
      @user.jobs.delete @job
    end
    redirect_to @user
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # Before filters
    
end