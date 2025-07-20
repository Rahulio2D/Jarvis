require 'rails_helper'

RSpec.describe OpenAiClient do
  describe '#call' do
    before do
        allow(Rails.application.credentials).to receive(:openai).and_return({ api_key: 'test_key' })
        allow(OpenAI::Client).to receive(:new).and_return(double(chat: double(completions: double(create: double(choices: [ double(message: double(content: 'Hello, world!')) ])))))
    end

    subject(:call) { OpenAiClient.new.call('example prompt') }

    it 'returns a response from the OpenAI API' do
      expect(call).to eq('Hello, world!')
    end

    context 'when the OpenAI API returns an error' do
      before do
        allow(OpenAI::Client).to receive(:new)
          .and_raise(
            OpenAI::Errors::APIStatusError.new(
              url: 'https://api.openai.com/v1/chat/completions',
              status: 500,
              body: 'Internal Server Error',
              response: double(body: 'Internal Server Error'),
              request: double(body: 'Request body')
            )
        )
      end

      it 'raises the error so it can be handled upstream' do
        expect { call }.to raise_error(OpenAI::Errors::APIStatusError)
      end
    end
  end
end
