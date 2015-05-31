class TransactionsController < ApplicationController

  def paid
    puts ">>>>>>>>>>>>>>>>>>>>>#{request.user_agent}"
    puts ">>>>>>>>>>>>>>>>>>>>>#{request.user_agent == "PayPal IPN ( https://www.paypal.com/ipn )"}"
  end

end
