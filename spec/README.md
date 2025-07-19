# RSpec Testing

This project uses RSpec for testing instead of Rails' default Minitest.

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/requests/health_check_spec.rb

# Run tests with Rake
bin/rails spec:all

# Run tests with coverage
bin/rails spec:coverage
```

## Directory Structure

- `spec/requests/` - Request/controller specs
- `spec/models/` - Model specs
- `spec/helpers/` - Helper specs
- `spec/factories/` - FactoryBot factories
- `spec/support/` - Support files and configurations

## Configuration

- RSpec is configured in `spec/rails_helper.rb`
- FactoryBot is included for test data generation
- Support files are auto-loaded from `spec/support/`
- Test database uses transactional fixtures for speed

## Writing Tests

```ruby
# Example request spec
RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a list of users' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end
  end
end

# Example model spec
RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end
end
``` 