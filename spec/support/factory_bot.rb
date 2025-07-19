RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# Only load factories if they haven't been loaded yet
unless FactoryBot.factories.registered?(:person)
  FactoryBot.definition_file_paths = [File.join(File.dirname(__FILE__), '..', 'factories')]
  FactoryBot.find_definitions
end 