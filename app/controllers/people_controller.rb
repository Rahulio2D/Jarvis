class PeopleController < ApplicationController
  def show
    person = PeopleService.find_by_uid(params[:uid])

    if person
      render json: PersonSerializer.new(person).serializable_hash
    else
      render json: {
        errors: [
          errors_hash(404, 'Not Found', 'Person not found')
        ]
      }, status: :not_found
    end
  end

  def create
    attributes = params.to_unsafe_h.dig(:data, :attributes) || {}
    result = PeopleService.create(attributes)

    if result.is_a?(Person)
      render json: PersonSerializer.new(result).serializable_hash, status: :created
    else
      render json: {
        errors: result[:errors].map do |field, messages|
          errors_hash(400, 'Bad Request', "#{field}: #{Array(messages).join(', ')}")
        end
      }, status: :bad_request
    end
  end
end
