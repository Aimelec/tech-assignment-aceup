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
        }
      },
      required: [ :data ]
    }
  end
end
