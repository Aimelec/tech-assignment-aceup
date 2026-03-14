module Orders
  class CreateOrder
    def self.with(params:)
      new(params:).execute
    end

    def initialize(params:)
      @params = params
    end

    def execute
      Order.create!(@params)
    end
  end
end
