# frozen_string_literal: true

module ExternalTickers
  class SearchExternal < Actor
    input :ticker_index_contract

    output :external_ticker
    output :ticker_index_contract

    def call
      external_ticker = search_external_ticker(ticker_index_contract:)

      return fail!(error: { message: "Stock ticker not found!", code: :not_found }) if external_ticker["results"].nil?

      self.external_ticker = external_ticker
    end

    private

    def search_external_ticker(ticker_index_contract:)
      tickers_url = PolygonUrlProvider.tickers_url(ticker_index_contract:)
      response = HTTParty.get(tickers_url)
      if response.success?
        JSON.parse(response.body)
      else
        fail!(error: { message: response.body, code: response.code })
      end
    end
  end
end
