# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickers::Repository, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(ticker_with_metrics: ticker) }

    context "when external_ticker is valid" do
      let(:ticker) { build(:ticker, ticker_results: build_list(:ticker_result, 1)) }

      it { expect(result.success?).to be_truthy }

      it "returns a persisted ticker" do
        expect(result.persisted_ticker).to be_persisted
      end
    end

    context "when external_ticker is invalid" do
      let(:ticker) { build(:ticker, average_price: nil) }

      it { expect(result.failure?).to be_truthy }

      it "returns a persisted ticker" do
        expect(result.persisted_ticker).to be_nil
      end

      it "returns error code" do
        expect(result.error[:code]).to eq(:unprocessable_entity)
      end

      it "returns error message" do
        expect(result.error[:message]).to eq(["Average price can't be blank"])
      end
    end
  end
end
