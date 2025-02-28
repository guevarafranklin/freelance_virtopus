class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contract, only: [:show]
  
  def index
    if current_user.client?
      @contracts = current_user.contracts_as_client
    else
      @contracts = current_user.contracts_as_freelancer
    end
  end
  
  def show
    authorize! :read, @contract
    @time_entries = @contract.time_entries
    @payments = @contract.payments
  end
  
  def new
    @proposal = Proposal.find(params[:proposal_id])
    @job = @proposal.job
    authorize! :create, Contract.new(client: @job.client)
    @contract = Contract.new
  end
  
  def create
    @proposal = Proposal.find(params[:contract][:proposal_id])
    @job = @proposal.job
    
    @contract = Contract.new(
      job: @job,
      client: current_user,
      freelancer: @proposal.freelancer,
      amount: params[:contract][:amount],
      start_date: params[:contract][:start_date],
      end_date: params[:contract][:end_date],
      status: 'active'
    )
    
    authorize! :create, @contract
    
    if @contract.save
      @proposal.update(status: 'accepted')
      @job.update(status: 'in_progress')
      
      redirect_to @contract, notice: 'Contract created successfully'
    else
      render :new
    end
  end
  
  private
  
  def set_contract
    @contract = Contract.find(params[:id])
  end
end
