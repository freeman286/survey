class TransactionsController < ApplicationController

  def paid
    puts ">>>>>>>>>>>>>>>>>>>>>#{request.https_user_agent}"
    puts ">>>>>>>>>>>>>>>>>>>>>#{request.https_user_agent == "PayPal IPN ( https://www.paypal.com/ipn )}"
  end

end
