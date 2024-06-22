# frozen_string_literal: true
module Tickers
  class Serializer < Actor
    input :persisted_ticker

    output :serialized_ticker

    def call
      self.serialized_ticker = formater(ticker: persisted_ticker)
    end

    private

    def formater(ticker:)
      [
        {
          item: 'Price',
          maximum: money_currency(ticker.maximum_price.to_i),
          minimum: money_currency(ticker.minimum_price.to_i),
          average: money_currency(ticker.average_price.to_i),
        },
        {
          item: 'Volume',
          maximum: ticker.maximum_volume.to_i.to_s,
          minimum: ticker.minimum_volume.to_i.to_s,
          average: ticker.average_volume.to_i.to_s,
        }
      ]
    end

    # TODO: Add gem rails-money
    def money_currency(value)
      "$#{value}"
    end
  end
end
