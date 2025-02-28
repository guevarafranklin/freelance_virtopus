class TimeEntriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @contract = Contract.find(params[:contract_id])
    authorize! :read, @contract
    
    @time_entries = @contract.time_entries
    @time_entry = TimeEntry.new
  end
  
  def create
    @contract = Contract.find(params[:time_entry][:contract_id])
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.freelancer = current_user
    
    authorize! :create, @time_entry
    
    if @time_entry.save
      redirect_to contract_time_entries_path(@contract), notice: 'Time entry added successfully'
    else
      @time_entries = @contract.time_entries
      render :index
    end
  end
  
  private
  
  def time_entry_params
    params.require(:time_entry).permit(:contract_id, :hours, :description, :date)
  end
end
