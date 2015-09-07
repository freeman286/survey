class TransactionsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :except => [:paid]

  def paid
    @status = false
    @hash = params[:transaction_hash]
    if request.user_agent == "PayPal IPN ( https://www.paypal.com/ipn )" && params[:mc_gross] == "10.00"
      @status = Transaction.find_by_security_hash(params[:transaction_hash]).update_attributes(:completed => true)
    end
    if @status
      puts "HASH: #{@hash} COMPLETED"
    else
      puts "HASH: #{@hash} NOT COMPLETED"
    end
    render :layout => false
  end

  def thankyou
    @diagnostic = current_user.transactions.order("created_at").select{|t| t.completed}.last.diagnostic
  end

end
