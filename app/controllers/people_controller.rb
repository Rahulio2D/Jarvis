class PeopleController < ApplicationController
  def show
    person = PeopleService.find_by_uid(params[:uid])

    if person
      render json: PersonSerializer.new(person).serializable_hash
    else
      render json: {
        errors: [
          {
            status: '404',
            title: 'Not Found',
            detail: 'Person not found'
          }
        ]
      }, status: :not_found
    end
  end
end
