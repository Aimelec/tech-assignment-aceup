class SendOrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    email_service.send_confirmation(order)
  end

  private

  def email_service
    @email_service ||= EmailService.new
  end
end
