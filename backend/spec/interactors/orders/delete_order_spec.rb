require "rails_helper"

RSpec.describe Orders::DeleteOrder, type: :interactor do
  describe ".of" do
    context "when order exists" do
      let!(:order) { create(:order) }

      it "deletes the order" do
        expect { described_class.of(id: order.id) }.to change(Order, :count).by(-1)
      end

      it "returns the deleted order" do
        deleted = described_class.of(id: order.id)

        expect(deleted).to be_a(Order)
        expect(deleted).to be_destroyed
      end
    end

    context "when order does not exist" do
      it "raises a record not found error" do
        expect { described_class.of(id: 0) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
