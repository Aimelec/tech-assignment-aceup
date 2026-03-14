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
      Order.create!(@params)
    end

    private

    def validate!
      result = CreateOrderContract.new.call(@params)
      raise ContractValidationError, result.errors.to_h if result.failure?
    end
  end
end
