class TransactionsController < ApplicationController

  def paid
    if request.user_agent == "PayPal IPN ( https://www.paypal.com/ipn )"
      Transaction.find_by_security_hash(params[:transaction_hash]).first.update_attribute(:completed => true)
    end
  end

end
