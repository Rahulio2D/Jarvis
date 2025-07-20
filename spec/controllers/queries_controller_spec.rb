require 'rails_helper'

RSpec.describe QueriesController, type: :controller do
  describe 'POST #create' do
    let(:query) { 'What is the weather like today?' }
    let(:openai_response) { 'The weather is sunny and warm.' }
    let(:openai_client) { instance_double(OpenAiClient) }

    before do
      allow(OpenAiClient).to receive(:new).and_return(openai_client)
      allow(openai_client).to receive(:call).with(query).and_return(openai_response)
    end

    context 'with valid query parameter' do
      it 'returns the OpenAI response' do
        post :create, params: {
          data: {
            type: 'query',
            attributes: { query: query }
          }
        }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'data' => {
            'type' => 'query',
            'attributes' => {
              'response' => openai_response
            }
          }
        })
      end
    end

    context 'with missing query parameter' do
      it 'returns a bad request error' do
        post :create, params: {}

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({
          'errors' => [ {
            'status' => 400,
            'title' => 'Bad Request',
            'detail' => 'Query attribute is required'
          } ]
        })
      end
    end

    context 'with blank query parameter' do
      it 'returns a bad request error' do
        post :create, params: {
          data: {
            type: 'query',
            attributes: { query: '' }
          }
        }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({
          'errors' => [ {
            'status' => 400,
            'title' => 'Bad Request',
            'detail' => 'Query attribute is required'
          } ]
        })
      end
    end

    context 'when OpenAiClient raises an error' do
      before do
        allow(openai_client).to receive(:call).and_raise(StandardError.new('API Error'))
      end

      it 'returns an internal server error' do
        post :create, params: {
          data: {
            type: 'query',
            attributes: { query: query }
          }
        }

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to eq({
          'errors' => [ {
            'status' => 500,
            'title' => 'Internal Server Error',
            'detail' => 'API Error'
          } ]
        })
      end
    end
  end
end
