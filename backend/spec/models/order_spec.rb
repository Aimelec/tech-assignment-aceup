require "rails_helper"

RSpec.describe Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:customer_name) }
    it { is_expected.to validate_presence_of(:customer_email) }
    it { is_expected.to validate_presence_of(:total_amount) }

    it { is_expected.to allow_value("user@example.com").for(:customer_email) }
    it { is_expected.not_to allow_value("invalid-email").for(:customer_email) }

    it { is_expected.to validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, confirmed: 1, completed: 2, cancelled: 3) }
  end

  describe "scopes" do
    describe ".recent" do
      it "orders by created_at descending" do
        old_order = create(:order, created_at: 1.day.ago)
        new_order = create(:order, created_at: 1.hour.ago)

        expect(Order.recent).to eq([ new_order, old_order ])
      end
    end
  end
end
