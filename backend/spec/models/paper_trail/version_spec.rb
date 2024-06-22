# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaperTrail::Version, versioning: true do
  let(:ticker) { create(:ticker) }

  context "when create object in database" do
    it "creates version" do
      expect(ticker).to be_persisted
      expect(ticker.versions.count).to eq(1)
    end
  end

  context "when update object in database" do
    let(:update_ticker) { ticker.update!(average_price: 800.0) }
    let(:ticker_version) { ticker.versions }
    let(:last_ticker_version) { ticker_version.last }
    let(:last_object_version) { PaperTrail.serializer.load(last_ticker_version.object) }

    before { update_ticker }

    it { expect(ticker_version.count).to eq(2) }
    it { expect(last_object_version["average_price"]).to eq(140.0) }
    it { expect(last_object_version["whodunnit"]).to be_nil }
  end
end
