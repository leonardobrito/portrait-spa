# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tickers::Serializer, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(ticker:) }
    let(:ticker) { create(:ticker, ticker_results: build_list(:ticker_result, 1)) }

    it { expect(result.success?).to be true }

    it "returns ticker with proper fields" do
      expect(result.serialized_ticker).to eq(
        [
          {
            item: 'Price',
            maximum: '$150',
            minimum: '$130',
            average: '$140'
          },
          {
            item: 'Volume',
            maximum: '100000',
            minimum: '50000',
            average: '75000'
          },
        ]
      )
  end
  end
end
