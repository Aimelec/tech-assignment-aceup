class EmailService
  def initialize(provider: EmailProviders::MockProvider.new)
    @provider = provider
  end

  def send_confirmation(order)
    @provider.send_confirmation(order)
  end
end
