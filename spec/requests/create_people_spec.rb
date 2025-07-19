require 'rails_helper'

RSpec.describe 'People', type: :request do
  describe 'POST /people' do
    let(:valid_attributes) do
      {
        name: 'John Doe',
        phone_number: '+1-555-123-4567',
        email: 'john@example.com',
        date_of_birth: '1990-01-01',
        relation: 'Friend'
      }
    end

    let(:request_payload) do
      {
        data: {
          type: 'people',
          attributes:
        }
      }
    end
    let(:attributes) { valid_attributes }

    subject(:create_person) { post '/people', params: request_payload, as: :json }

    context 'with valid parameters' do
      it 'creates a new person and returns 201 status' do
        expect { create_person }.to change(Person, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq(
          'data' => {
            'type' => 'people',
            'attributes' => {
              'name' => 'John Doe',
              'phone_number' => '+1-555-123-4567',
              'email' => 'john@example.com',
              'date_of_birth' => '1990-01-01',
              'relation' => 'Friend'
            },
            'id' => Person.last.uid
          }
        )
      end
    end

    context 'with invalid parameters' do
      let(:attributes) { {} }

      it 'does not create a new person and returns validation errors for invalid fields' do
        expect { create_person }.not_to change(Person, :count)

        expect(response).to have_http_status(:bad_request)

        expect(JSON.parse(response.body)).to eq(
          'errors' => [
            {
              'detail' => 'name: is missing',
              'status' => 400,
              'title' => 'Bad Request'
            },
            {
              'detail' => 'relation: is missing',
              'status' => 400,
              'title' => 'Bad Request'
            },
            {
              'detail' => 'base: at least one contact method (phone number or email) must be provided',
              'status' => 400,
              'title' => 'Bad Request'
            }
          ]
        )
      end
    end
  end
end
