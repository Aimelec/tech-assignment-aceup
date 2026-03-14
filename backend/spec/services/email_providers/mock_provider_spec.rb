require "rails_helper"

RSpec.describe EmailProviders::MockProvider do
  describe "#send_confirmation" do
    let(:order) { create(:order) }

    it "delivers the confirmation email" do
      expect { described_class.new.send_confirmation(order) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
