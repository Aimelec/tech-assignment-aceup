module Swagger
  def order_stats_output_definition
    {
      type: :object,
      properties: {
        type: { type: :string, example: "stats" },
        attributes: {
          type: :object,
          properties: {
            total_orders: { type: :integer, example: 10 },
            cancelled_orders: { type: :integer, example: 1 },
            completed_orders: { type: :integer, example: 4 },
            in_progress_orders: { type: :integer, example: 5 },
            total_revenue: { type: :string, example: "200.0" }
          },
          required: %i[total_orders cancelled_orders completed_orders in_progress_orders total_revenue]
        }
      },
      required: %i[type attributes]
    }
  end
end
