class TransactionsController < ApplicationController

  def paid
    if request.user_agent == "PayPal IPN ( https://www.paypal.com/ipn )" && params[:mc_gross] == "10.00"
      Transaction.find_by_security_hash(params[:transaction_hash]).update_attributes(:completed => true)
    end
  end

  def thankyou
    @diagnostic = current_user.transactions.order("created_at").select{|t| t.completed}.last.diagnostic
  end

end
