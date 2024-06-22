# frozen_string_literal: true

module ExternalTickers
  class Parser < Actor
    input :external_ticker
    input :ticker_index_contract

    output :ticker

    def call
      self.ticker = parse_ticker(external_ticker:, ticker_index_contract:)
    end

    private

    def parse_ticker(external_ticker:, ticker_index_contract:)
      name = external_ticker["ticker"]
      input_params = ticker_index_contract.to_hash
      ticker = Ticker.new(name:, input_params:)
      ticker.ticker_results = parse_ticker_results(external_ticker["results"])
      ticker
    end

    def parse_ticker_results(external_ticker_results)
      external_ticker_results.map do |external_ticker_result|
        TickerResult.new(
          close_price: external_ticker_result[label(:close_price)],
          highest_price: external_ticker_result[label(:highest_price)],
          lowest_price: external_ticker_result[label(:lowest_price)],
          transactions_number: external_ticker_result[label(:transactions_number)],
          open_price: external_ticker_result[label(:open_price)],
          otc: false,
          aggregate_window_start_at: timestamp_to_datetime(external_ticker_result[label(:aggregate_window_start_at)]),
          trading_volume: external_ticker_result[label(:trading_volume)],
          volume_weighted_average_price: external_ticker_result[label(:volume_weighted_average_price)]
        )
      end
    end

    def label(field)
      PolygonUrlProvider::LABEL_DICTIONARY[field]
    end

    def timestamp_to_datetime(timestamp_in_milliseconds)
      # TODO: change precision to milliseconds
      timestamp_in_seconds = timestamp_in_milliseconds / 1000.0
      Time.zone.at(timestamp_in_seconds).to_datetime
    end
  end
end
