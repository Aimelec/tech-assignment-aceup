class OrderMailer < ApplicationMailer
  def confirmation(order)
    @order = order
    mail(to: order.customer_email, subject: "Order Confirmation ##{order.id}")
  end
end
