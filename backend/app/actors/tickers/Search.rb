# frozen_string_literal: true
module Tickers
  class Search < Actor
    input :ticker_index_contract
    output :persisted_ticker

    play ExternalTickers::SearchExternal,
         ExternalTickers::Parser,
         ExternalTickers::CalculateMetrics,
         Repository,
         Serializer
  end
end
