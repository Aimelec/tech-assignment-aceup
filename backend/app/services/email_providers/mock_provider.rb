module EmailProviders
  class MockProvider
    def send_confirmation(order)
      OrderMailer.confirmation(order).deliver_now
    end
  end
end
