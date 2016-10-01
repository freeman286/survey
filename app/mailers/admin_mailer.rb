class AdminMailer < ActionMailer::Base
  default from: "noreply@archimedes-earth.com"

  def notify_admin_completed(transaction, host)
    @transaction = transaction
    @user = @transaction.user
    @diagnostic = @transaction.diagnostic.name
    @host = host
    mail(to: "molemayer@gmail.com", subject: "Diagnostic report purchased")
  end
end
