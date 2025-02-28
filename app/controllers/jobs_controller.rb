class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  
  def index
    @jobs = Job.where(status: 'open')
  end
  
  def show
    @proposal = Proposal.new
  end
  
  def new
    authorize! :create, Job
    @job = Job.new
  end
  
  def create
    authorize! :create, Job
    @job = current_user.jobs.build(job_params)
    
    if @job.save
      redirect_to @job, notice: 'Job posted successfully'
    else
      render :new
    end
  end
  
  def edit
    authorize! :update, @job
  end
  
  def update
    authorize! :update, @job
    
    if @job.update(job_params)
      redirect_to @job, notice: 'Job updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    authorize! :destroy, @job
    @job.destroy
    
    redirect_to jobs_path, notice: 'Job deleted successfully'
  end
  
  private
  
  def set_job
    @job = Job.find(params[:id])
  end
  
  def job_params
    params.require(:job).permit(:title, :description, :budget, :deadline, :skills_required)
  end
end
