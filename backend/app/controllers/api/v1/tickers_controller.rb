# frozen_string_literal: true

module Api
  module V1
    class TickersController < Api::V1::ApiController
      skip_before_action :authenticate_devise_api_token!, only: :index
      skip_after_action :verify_authorized

      def index
        external_tickers_result = ExternalTickers::SearchExternal.result(ticker_index_contract:)

        return render json: { message: external_tickers_result.error }, status: external_tickers_result.error[:code] unless external_tickers_result.success?

        parser_ticker = ExternalTickers::Parser.result(
          external_ticker: external_tickers_result.external_ticker,
          ticker_index_contract:
        )

        return render json: { message: parser_ticker.error }, status: :not_found unless parser_ticker.success?

        ticker_with_metrics = ExternalTickers::CalculateMetrics.result(ticker: parser_ticker.ticker).ticker_with_metrics
        persisted_ticker = Tickers::Repository.result(ticker: ticker_with_metrics).persisted_ticker

        # TODO: move all services above this comment to a single service and check if services nesting works. Only do this after everything is working
        # TODO: add cache based on ticker input_params. This is tricky because if the end_date is after now, cache wont work

        if persisted_ticker.persisted?
          serialized_ticker = Tickers::Serializer.result(ticker: persisted_ticker).serialized_ticker
          render json: serialized_ticker, status: :ok
        else
          render json: { message: persisted_ticker.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def ticker_index_contract
        @ticker_index_contract ||= TickerContracts::Index.call(permitted_params(:ticker_name, :from_date, :to_date))
      end
    end
  end
end
