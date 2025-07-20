class QueriesController < ApplicationController
  def create
    # Extract query from JSON API compliant request body
    query_data = params.dig(:data, :attributes, :query)

    if query_data.blank?
      render json: {
        errors: [
            errors_hash(400, 'Bad Request', 'Query attribute is required')
        ]
      }, status: :bad_request
      return
    end

    begin
      response = OpenAiClient.new.call(query_data)
      render json: {
        data: {
          type: 'query',
          attributes: {
            response: response
          }
        }
      }
    rescue => e
      render json: {
        errors: [
            errors_hash(500, 'Internal Server Error', e.message)
        ]
      }, status: :internal_server_error
    end
  end
end
