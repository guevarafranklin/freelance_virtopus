class PaymentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @contract = Contract.find(params[:contract_id])
    authorize! :read, @contract
    
    @payments = @contract.payments
    @payment = Payment.new
  end
  
  def create
    @contract = Contract.find(params[:payment][:contract_id])
    authorize! :create, Payment.new(contract: @contract)
    
    amount = params[:payment][:amount].to_f
    
    begin
      # This is where you'd integrate with Stripe or another payment processor
      # For demo purposes, we'll just create the payment record
      
      @payment = Payment.new(
        contract: @contract,
        amount: amount,
        status: 'completed',
        payment_method: 'credit_card',
        transaction_id: "demo-#{Time.now.to_i}"
      )
      
      if @payment.save
        redirect_to contract_payments_path(@contract), notice: 'Payment processed successfully'
      else
        @payments = @contract.payments
        render :index
      end
    rescue => e
      flash[:alert] = "Payment error: #{e.message}"
      redirect_to contract_payments_path(@contract)
    end
  end
end
