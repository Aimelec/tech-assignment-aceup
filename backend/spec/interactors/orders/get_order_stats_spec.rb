require "rails_helper"

RSpec.describe Orders::GetOrderStats, type: :interactor do
  describe ".get" do
    let!(:in_progress_orders) { create_list(:order, 5, status: :in_progress, total_amount: 16.00) }
    let!(:completed_orders) { create_list(:order, 4, status: :completed, total_amount: 30.00) }
    let!(:cancelled_orders) { create_list(:order, 1, status: :cancelled, total_amount: 50.00) }

    subject(:result) { described_class.get }

    it "returns the total number of orders" do
      expect(result[:total_orders]).to eq(10)
    end

    it "returns the number of in progress orders" do
      expect(result[:in_progress_orders]).to eq(5)
    end

    it "returns the number of cancelled orders" do
      expect(result[:cancelled_orders]).to eq(1)
    end

    it "returns the number of completed orders" do
      expect(result[:completed_orders]).to eq(4)
    end

    it "returns the total revenue excluding cancelled orders" do
      expected = (5 * 16.00) + (4 * 30.00)
      expect(result[:total_revenue]).to eq(expected)
    end

    context "when there are no orders" do
      before { Order.destroy_all }

      it "returns all zeros" do
        expect(result).to eq(
          total_orders: 0,
          cancelled_orders: 0,
          completed_orders: 0,
          in_progress_orders: 0,
          total_revenue: 0
        )
      end
    end
  end
end
