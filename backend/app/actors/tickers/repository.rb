# frozen_string_literal: true
module Tickers
  class Repository < Actor
    input :ticker_with_metrics

    output :persisted_ticker

    def call
      self.persisted_ticker = persist_ticker(ticker: ticker_with_metrics)
    end

    private

    def persist_ticker(ticker:)
      if ticker.save
        ticker
      else
        fail!(error: { message: ticker.errors.full_messages, code: :unprocessable_entity })
      end
    end
  end
end
