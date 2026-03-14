require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "#confirmation" do
    let(:order) { create(:order, customer_name: "John Doe", customer_email: "john@example.com") }
    let(:mail) { described_class.confirmation(order) }

    it "sends to the customer email" do
      expect(mail.to).to eq([ "john@example.com" ])
    end

    it "includes the order id in the subject" do
      expect(mail.subject).to eq("Order Confirmation ##{order.id}")
    end

    it "includes the customer name in the body" do
      expect(mail.body.encoded).to include("John Doe")
    end
  end
end
