module Orders
  class DeleteOrder
    def self.of(id:)
      new(id:).execute
    end

    def initialize(id:)
      @id = id
    end

    def execute
      order.destroy!
      order
    end

    private

    def order
      @order ||= Order.find(@id)
    end
  end
end
