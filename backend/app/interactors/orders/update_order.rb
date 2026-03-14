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
      order.update!(@params)
      order
    end

    private

    def order
      @order ||= Order.find(@id)
    end
  end
end
