class TransactionsController < ApplicationController

  def paid
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{request.env}"
    if request.user_agent == "PayPal IPN ( https://www.paypal.com/ipn )"
      Transaction.find_by_security_hash(params[:transaction_hash]).update_attributes(:completed => true)
    end
  end

end
