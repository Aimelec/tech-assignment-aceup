module Orders
  class CreateOrder
    def self.with(params:)
      new(params:).execute
    end

    def initialize(params:)
      @params = params
    end

    def execute
      validate!
      order = Order.create!(@params)
      send_confirmation_email(order)
      order
    end

    private

    def send_confirmation_email(order)
      SendOrderConfirmationJob.perform_later(order.id)
    end

    def validate!
      result = CreateOrderContract.new.call(@params)
      raise ContractValidationError, result.errors.to_h if result.failure?
    end
  end
end
