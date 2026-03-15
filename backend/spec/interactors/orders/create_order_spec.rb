require "rails_helper"

RSpec.describe Orders::CreateOrder, type: :interactor do
  describe ".with" do
    context "with valid params" do
      let(:params) do
        {
          customer_name: "John Doe",
          customer_email: "john@example.com",
          description: "Test order",
          total_amount: 99.99
        }
      end

      it "creates a new order" do
        expect { described_class.with(params: params) }.to change(Order, :count).by(1)
      end

      it "returns the created order" do
        order = described_class.with(params: params)

        expect(order.customer_name).to eq("John Doe")
        expect(order.customer_email).to eq("john@example.com")
        expect(order.description).to eq("Test order")
        expect(order.total_amount).to eq(99.99)
      end

      it "sets the default status to in_progress" do
        order = described_class.with(params: params)

        expect(order).to be_in_progress
      end

      it "enqueues a confirmation email job" do
        expect { described_class.with(params: params) }
          .to have_enqueued_job(SendOrderConfirmationJob)
      end
    end

    context "with invalid params" do
      it "raises a contract validation error when customer_name is missing" do
        params = { customer_email: "john@example.com", total_amount: 99.99 }

        expect { described_class.with(params: params) }.to raise_error(ContractValidationError)
      end

      it "raises a contract validation error when customer_email is invalid" do
        params = { customer_name: "John", customer_email: "invalid", total_amount: 99.99 }

        expect { described_class.with(params: params) }.to raise_error(ContractValidationError)
      end

      it "raises a contract validation error when total_amount is negative" do
        params = { customer_name: "John", customer_email: "john@example.com", total_amount: -10 }

        expect { described_class.with(params: params) }.to raise_error(ContractValidationError)
      end

      it "includes validation messages in the error" do
        params = { customer_email: "john@example.com", total_amount: 99.99 }

        expect { described_class.with(params: params) }.to raise_error(ContractValidationError) do |error|
          expect(error.errors).to have_key(:customer_name)
        end
      end
    end
  end
end
