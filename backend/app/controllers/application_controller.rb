class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ContractValidationError, with: :render_contract_errors

  private

  def serialize(resource)
    serializer = "#{resource.class}Serializer".constantize
    serializer.new(resource).serializable_hash
  end

  def serialize_collection(resources, meta: {})
    serializer = "#{resources.klass}Serializer".constantize
    serializer.new(resources).serializable_hash.merge(meta: meta)
  end

  def render_not_found(exception)
    render json: {
      errors: [ { status: "404", title: "Not Found", detail: exception.message } ]
    }, status: :not_found
  end

  def render_contract_errors(exception)
    errors = exception.errors.map do |field, messages|
      messages.map do |message|
        { status: "422", title: "Validation Error", detail: "#{field} #{message}", source: { pointer: "/data/attributes/#{field}" } }
      end
    end.flatten

    render json: { errors: errors }, status: :unprocessable_entity
  end
end
