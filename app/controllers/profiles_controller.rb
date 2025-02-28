class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  
  def show
  end
  
  def edit
    authorize! :update, @profile
  end
  
  def update
    authorize! :update, @profile
    
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end
  
  private
  
  def set_profile
    @profile = params[:id] ? Profile.find(params[:id]) : current_user.profile
  end
  
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :title, :bio, :hourly_rate, :skills, :avatar)
  end
end