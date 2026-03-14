module Orders
  class CreateOrderContract < Dry::Validation::Contract
    params do
      required(:customer_name).filled(:string)
      required(:customer_email).filled(:string)
      required(:total_amount).filled(:decimal)
      optional(:description).maybe(:string)
    end

    rule(:customer_email) do
      key.failure("must have email format") unless value.match?(URI::MailTo::EMAIL_REGEXP)
    end

    rule(:total_amount) do
      key.failure("must be greater than or equal to 0") if value.negative?
    end
  end
end
