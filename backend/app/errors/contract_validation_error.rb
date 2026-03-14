class ContractValidationError < StandardError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
    super(errors.map { |field, messages| "#{field} #{messages.join(', ')}" }.join("; "))
  end
end
