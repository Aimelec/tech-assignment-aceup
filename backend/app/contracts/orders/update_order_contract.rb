module Orders
  class UpdateOrderContract < Dry::Validation::Contract
    VALID_STATUSES = %w[pending confirmed completed cancelled].freeze

    params do
      optional(:customer_name).filled(:string)
      optional(:customer_email).filled(:string)
      optional(:total_amount).filled(:decimal)
      optional(:description).maybe(:string)
      optional(:status).filled(:string)
    end

    rule(:customer_email) do
      key.failure("must have email format") if key? && !value.match?(URI::MailTo::EMAIL_REGEXP)
    end

    rule(:total_amount) do
      key.failure("must be greater than or equal to 0") if key? && value.negative?
    end

    rule(:status) do
      key.failure("must be one of: #{VALID_STATUSES.join(', ')}") if key? && !VALID_STATUSES.include?(value)
    end
  end
end
