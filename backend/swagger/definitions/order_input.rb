module Swagger
  def order_input_definition
    {
      type: :object,
      properties: {
        order: {
          type: :object,
          properties: {
            customer_name: { type: :string, example: "John Doe" },
            customer_email: { type: :string, example: "john@example.com" },
            description: { type: :string, example: "2x Margherita Pizza, 1x Tiramisu" },
            total_amount: { type: :number, example: 99.99 },
            status: { type: :string, enum: %w[pending confirmed completed cancelled] }
          },
          required: %w[customer_name customer_email total_amount]
        }
      }
    }
  end
end
