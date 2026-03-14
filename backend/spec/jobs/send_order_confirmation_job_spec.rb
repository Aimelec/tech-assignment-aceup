require "rails_helper"

RSpec.describe SendOrderConfirmationJob, type: :job do
  describe "#perform" do
    let(:order) { create(:order) }

    it "sends a confirmation email through the email service" do
      email_service = instance_double(EmailService)
      allow(EmailService).to receive(:new).and_return(email_service)
      allow(email_service).to receive(:send_confirmation)

      described_class.perform_now(order.id)

      expect(email_service).to have_received(:send_confirmation).with(order)
    end
  end
end
