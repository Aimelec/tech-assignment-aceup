module Swagger
  def order_update_input_definition
    {
      type: :object,
      properties: {
        order: {
          type: :object,
          properties: {
            customer_name: { type: :string },
            customer_email: { type: :string },
            description: { type: :string },
            total_amount: { type: :number },
            status: { type: :string, enum: %w[pending confirmed completed cancelled] }
          }
        }
      }
    }
  end
end
