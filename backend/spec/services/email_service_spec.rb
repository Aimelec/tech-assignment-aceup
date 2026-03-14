require "rails_helper"

RSpec.describe EmailService do
  describe "#send_confirmation" do
    let(:order) { create(:order) }
    let(:provider) { instance_double(EmailProviders::MockProvider) }

    it "delegates to the provider" do
      allow(provider).to receive(:send_confirmation)

      described_class.new(provider: provider).send_confirmation(order)

      expect(provider).to have_received(:send_confirmation).with(order)
    end
  end
end
