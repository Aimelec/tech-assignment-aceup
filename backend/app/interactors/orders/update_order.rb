module Orders
  class UpdateOrder
    def self.with(id:, params:)
      new(id:, params:).execute
    end

    def initialize(id:, params:)
      @id = id
      @params = params
    end

    def execute
      validate!
      order.update!(@params)
      order
    end

    private

    def validate!
      result = UpdateOrderContract.new.call(@params)
      raise ContractValidationError, result.errors.to_h if result.failure?
    end

    def order
      @order ||= Order.find(@id)
    end
  end
end
