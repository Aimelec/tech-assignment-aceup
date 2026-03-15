require "rails_helper"

RSpec.describe Orders::UpdateOrderContract do
  subject(:contract) { described_class.new }

  context "with valid params" do
    it "passes with only customer_name" do
      result = contract.call(customer_name: "New Name")

      expect(result).to be_success
    end

    it "passes with only customer_email" do
      result = contract.call(customer_email: "new@example.com")

      expect(result).to be_success
    end

    it "passes with only total_amount" do
      result = contract.call(total_amount: 50.0)

      expect(result).to be_success
    end

    it "passes with only status" do
      result = contract.call(status: "in_progress")

      expect(result).to be_success
    end

    it "passes with multiple fields" do
      result = contract.call(customer_name: "New Name", status: "completed")

      expect(result).to be_success
    end
  end

  context "with invalid params" do
    it "fails when customer_email has invalid format" do
      result = contract.call(customer_email: "invalid")

      expect(result).to be_failure
      expect(result.errors[:customer_email]).to include("must have email format")
    end

    it "fails when total_amount is negative" do
      result = contract.call(total_amount: -10)

      expect(result).to be_failure
      expect(result.errors[:total_amount]).to include("must be greater than or equal to 0")
    end

    it "fails when status is not a valid value" do
      result = contract.call(status: "invalid_status")

      expect(result).to be_failure
      expect(result.errors[:status]).to include("must be one of: in_progress, completed, cancelled")
    end
  end
end
