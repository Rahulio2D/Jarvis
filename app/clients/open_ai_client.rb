class OpenAiClient
  def initialize
    @client = OpenAI::Client.new(api_key: Rails.application.credentials.openai[:api_key])
  end

  def call(prompt)
    chat_completion = client.chat.completions.create(
      messages: [ { role: 'user', content: prompt } ],
      model: :"gpt-4o-mini"
    )

    # Only return the first message in the response. Comment this out if you want to return the entire response for debugging.
    chat_completion.choices.first.message.content
  end

  private

  attr_reader :client
end
