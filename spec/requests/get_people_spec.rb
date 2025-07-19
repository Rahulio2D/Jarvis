require 'rails_helper'

RSpec.describe 'People', type: :request do
  describe 'GET /people/:uid' do
    let(:person) { create(:person, :with_email) }
    let(:uid) { person.uid }

    subject(:get_by_uid) { get "/people/#{uid}" }

    it 'returns the person with the correct JSON:API format' do
      get_by_uid

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({
        'data' => {
          'id' => person.uid,
          'type' => 'people',
          'attributes' => {
            'name' => person.name,
            'email' => person.email,
            'phone_number' => person.phone_number,
            'date_of_birth' => person.date_of_birth,
            'relation' => person.relation
          }
        }
      })
    end

    context 'when person not found' do
      let(:uid) { 'NONEXISTENT' }

      it 'returns a 404 status with JSON:API error format' do
        get_by_uid

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({
          'errors' => [
            {
              'status' => 404,
              'title' => 'Not Found',
              'detail' => 'Person not found'
            }
          ]
        })
      end
    end
  end
end
