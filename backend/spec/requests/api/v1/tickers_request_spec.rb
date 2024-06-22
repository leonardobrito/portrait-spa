# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tickers" do
  let(:tickers_url) { "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2023-01-01/2023-12-31?apiKey=taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx" }
  let(:httparty_response) { instance_double(HTTParty::Response, body: response_body, code: 200, success?: true) }
  let(:response_body) do
    {
      "ticker" => "AAPL",
      "queryCount" => 21,
      "resultsCount" => 12,
      "adjusted" => true,
      "results" => [
        {
          "v" => 201_218_104,
          "vw" => 126.133,
          "o" => 130.28,
          "c" => 126.36,
          "h" => 130.9,
          "l" => 124.17,
          "t" => 1_672_722_000_000,
          "n" => 1_791_107
        }
      ]
    }.to_json
  end

  before do
    allow(HTTParty).to receive(:get).with(tickers_url).and_return(httparty_response)
  end

  describe "GET /api/v1/tickets" do
    let(:ticker_name) { "AAPL" }
    let(:from_date) { "2023-01-01" }
    let(:to_date) { "2023-12-31" }

    before do
      get "/api/v1/tickers", params: { ticker_name:, from_date:, to_date: }, headers:
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
