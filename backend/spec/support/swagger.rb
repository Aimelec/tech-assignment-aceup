module Swagger
  def swagger_definitions
    {
      order_output: order_output_definition,
      order_input: order_input_definition,
      order_update_input: order_update_input_definition
    }
  end

  def object_response_schema(model)
    {
      type: :object,
      properties: {
        data: { "$ref": "#/components/schemas/#{model}" }
      },
      required: [ :data ]
    }
  end

  def collection_response_schema(model)
    {
      type: :object,
      properties: {
        data: {
          type: :array,
          items: { "$ref": "#/components/schemas/#{model}" }
        },
        meta: {
          type: :object,
          properties: {
            current_page: { type: :integer, example: 1 },
            total_pages: { type: :integer, example: 2 },
            total_count: { type: :integer, example: 7 }
          },
          required: [ :current_page, :total_pages, :total_count ]
        }
      },
      required: [ :data, :meta ]
    }
  end
end
