require "rails_helper"
Dir[Rails.root.join("swagger", "definitions", "*.rb")].each { |f| require f }
extend Swagger

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("swagger").to_s

  config.openapi_specs = {
    "swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "AceUp Orders API",
        version: "1.0",
        description: "Order management API following JSON:API specification"
      },
      paths: {},
      servers: [
        {
          url: "http://localhost:3000",
          description: "Development server"
        }
      ],
      components: {
        schemas: swagger_definitions
      }
    }
  }

  config.openapi_format = :yaml
  config.extend Swagger, type: :request
end
