require "rails_helper"

RSpec.describe Orders::CreateOrderContract do
  subject(:contract) { described_class.new }

  context "with valid params" do
    it "passes with all required fields" do
      result = contract.call(
        customer_name: "John Doe",
        customer_email: "john@example.com",
        total_amount: 99.99
      )

      expect(result).to be_success
    end

    it "passes with optional description" do
      result = contract.call(
        customer_name: "John Doe",
        customer_email: "john@example.com",
        total_amount: 99.99,
        description: "A test order"
      )

      expect(result).to be_success
    end
  end

  context "with invalid params" do
    it "fails when customer_name is missing" do
      result = contract.call(customer_email: "john@example.com", total_amount: 99.99)

      expect(result).to be_failure
      expect(result.errors[:customer_name]).to include("is missing")
    end

    it "fails when customer_email is missing" do
      result = contract.call(customer_name: "John", total_amount: 99.99)

      expect(result).to be_failure
      expect(result.errors[:customer_email]).to include("is missing")
    end

    it "fails when customer_email has invalid format" do
      result = contract.call(customer_name: "John", customer_email: "invalid", total_amount: 99.99)

      expect(result).to be_failure
      expect(result.errors[:customer_email]).to include("must have email format")
    end

    it "fails when total_amount is missing" do
      result = contract.call(customer_name: "John", customer_email: "john@example.com")

      expect(result).to be_failure
      expect(result.errors[:total_amount]).to include("is missing")
    end

    it "fails when total_amount is negative" do
      result = contract.call(customer_name: "John", customer_email: "john@example.com", total_amount: -10)

      expect(result).to be_failure
      expect(result.errors[:total_amount]).to include("must be greater than or equal to 0")
    end
  end
end
