require "rails_helper"

RSpec.describe Orders::UpdateOrder, type: :interactor do
  describe ".with" do
    let(:order) { create(:order, customer_name: "Old Name", status: :in_progress) }

    context "with valid params" do
      it "updates the order attributes" do
        updated = described_class.with(id: order.id, params: { customer_name: "New Name" })

        expect(updated.customer_name).to eq("New Name")
      end

      it "updates the order status" do
        updated = described_class.with(id: order.id, params: { status: "completed" })

        expect(updated).to be_completed
      end

      it "returns the updated order" do
        updated = described_class.with(id: order.id, params: { customer_name: "New Name" })

        expect(updated).to be_a(Order)
        expect(updated).to be_persisted
      end

      it "allows partial updates" do
        original_email = order.customer_email
        updated = described_class.with(id: order.id, params: { customer_name: "New Name" })

        expect(updated.customer_name).to eq("New Name")
        expect(updated.customer_email).to eq(original_email)
      end
    end

    context "with invalid params" do
      it "raises a contract validation error when customer_email is invalid" do
        expect {
          described_class.with(id: order.id, params: { customer_email: "invalid" })
        }.to raise_error(ContractValidationError)
      end

      it "raises a contract validation error when total_amount is negative" do
        expect {
          described_class.with(id: order.id, params: { total_amount: -10 })
        }.to raise_error(ContractValidationError)
      end

      it "raises a contract validation error when status is invalid" do
        expect {
          described_class.with(id: order.id, params: { status: "invalid_status" })
        }.to raise_error(ContractValidationError)
      end
    end

    context "when order does not exist" do
      it "raises a record not found error" do
        expect {
          described_class.with(id: 0, params: { customer_name: "New Name" })
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
