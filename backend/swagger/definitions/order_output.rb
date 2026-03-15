module Swagger
  def order_output_definition
    {
      type: :object,
      properties: {
        id: { type: :string },
        type: { type: :string, example: "order" },
        attributes: {
          type: :object,
          properties: {
            customer_name: { type: :string, example: "John Doe" },
            customer_email: { type: :string, example: "john@example.com" },
            description: { type: :string, example: "2x Margherita Pizza, 1x Tiramisu", nullable: true },
            total_amount: { type: :string, example: "99.99" },
            status: { type: :string, enum: %w[in_progress completed cancelled] },
            created_at: { type: :string, format: "date-time" },
            updated_at: { type: :string, format: "date-time" }
          },
          required: %i[customer_name customer_email total_amount status created_at updated_at]
        }
      },
      required: %i[id type attributes]
    }
  end
end
