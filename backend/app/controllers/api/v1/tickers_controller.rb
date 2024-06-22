# frozen_string_literal: true

module Api
  module V1
    class TickersController < Api::V1::ApiController
      skip_before_action :authenticate_devise_api_token!, only: :index
      skip_after_action :verify_authorized

      def index
        # TODO: add cache based on ticker input_params. This is tricky because if the end_date is after now, cache wont work
        result = Tickers::Search.result(ticker_index_contract:)

        return render(json: { message: result.error[:message] }, status: result.error[:code]) unless result.success?

        render(json: result.serialized_ticker, status: :ok)
      end

      private

      def ticker_index_contract
        @ticker_index_contract ||= TickerContracts::Index.call(permitted_params(:ticker_name, :from_date, :to_date))
      end
    end
  end
end
