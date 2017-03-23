class JobsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:show]
  before_action :allowed_user, only: [:show]
  
  def show
    @job = Job.find(params[:id])
  end
  
  def edit
    @job = Job.find(params[:id])
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job updated"
      redirect_to @job
    else
      render 'edit'
    end
  end
  
  def index
    @jobs = Job.paginate(page: params[:page])
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(job_params)
    if @job.save
      flash.now[:success] = "Job Created!"
      redirect_to jobs_path
    else
      render 'new'
    end
  end
  
  def delete
  end
  
  private

    def job_params
      params.require(:job).permit(:title, :description)
    end
    
    #before filters
    def allowed_user
      @job = Job.find(params[:id])
      redirect_to(root_url) unless current_user.admin? or @job.user_ids.include? current_user.id
    end

end
