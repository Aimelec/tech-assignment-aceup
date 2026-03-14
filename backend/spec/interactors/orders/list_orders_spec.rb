require "rails_helper"

RSpec.describe Orders::ListOrders, type: :interactor do
  describe ".with" do
    let!(:orders) { create_list(:order, 7) }

    it "returns paginated orders" do
      result = described_class.with(page: 1)

      expect(result[:orders].size).to eq(5)
    end

    it "returns the second page" do
      result = described_class.with(page: 2)

      expect(result[:orders].size).to eq(2)
    end

    it "returns orders in recent order" do
      result = described_class.with(page: 1)

      expect(result[:orders]).to eq(Order.recent.first(5))
    end

    it "includes pagination meta" do
      result = described_class.with(page: 1)

      expect(result[:meta]).to eq(
        current_page: 1,
        total_pages: 2,
        total_count: 7
      )
    end

    it "defaults to page 1 when page is nil" do
      result = described_class.with(page: nil)

      expect(result[:orders].size).to eq(5)
      expect(result[:meta][:current_page]).to eq(1)
    end
  end
end
