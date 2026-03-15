require "rails_helper"

RSpec.describe OrderSerializer, type: :serializer do
  describe "serialization" do
    let(:order) do
      create(:order,
        customer_name: "John Doe",
        customer_email: "john@example.com",
        description: "Test order",
        total_amount: 99.99,
        status: :in_progress)
    end

    let(:serialized) { described_class.new(order).serializable_hash }
    let(:attributes) { serialized[:data][:attributes] }

    it "returns the correct type and id" do
      expect(serialized[:data][:type]).to eq(:order)
      expect(serialized[:data][:id]).to eq(order.id.to_s)
    end

    it "includes all order attributes" do
      expect(attributes).to eq(
        customer_name: "John Doe",
        customer_email: "john@example.com",
        description: "Test order",
        total_amount: "99.99",
        status: "in_progress",
        created_at: order.created_at,
        updated_at: order.updated_at
      )
    end
  end

  describe "collection serialization" do
    let!(:orders) { create_list(:order, 3) }

    it "serializes a collection of orders" do
      serialized = described_class.new(orders).serializable_hash

      expect(serialized[:data].length).to eq(3)
      expect(serialized[:data].map { |d| d[:type] }).to all(eq(:order))
    end
  end
end
