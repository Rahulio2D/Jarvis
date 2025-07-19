# Testing Configuration

This project uses RSpec as the testing framework instead of Rails' default Minitest.

## Configuration

### Rails Generator Configuration

The Rails generators are configured in `config/application.rb` to use RSpec:

```ruby
config.generators do |g|
  g.test_framework :rspec,
    fixtures: false,        # Don't generate fixture files
    view_specs: false,      # Don't generate view specs
    helper_specs: false,    # Don't generate helper specs
    routing_specs: false,   # Don't generate routing specs
    controller_specs: true, # Generate controller specs
    request_specs: true     # Generate request specs
end
```

### What This Means

When you run Rails generators like:
- `bin/rails generate model User name:string`
- `bin/rails generate controller Users index show`
- `bin/rails generate scaffold Post title:string content:text`

Rails will automatically create:
- ✅ RSpec spec files in the `spec/` directory
- ❌ No Minitest files in the `test/` directory
- ❌ No fixture files (we use FactoryBot instead)

## Test Structure

```
spec/
├── models/           # Model specs
├── controllers/      # Controller specs
├── requests/         # Request specs
├── factories/        # FactoryBot factories
├── support/          # Support files and configurations
└── rails_helper.rb   # Rails-specific RSpec configuration
```

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/person_spec.rb

# Run tests with Rake
bin/rails spec:all

# Run tests with coverage
bin/rails spec:coverage
```

## Writing Tests

### Model Specs
```ruby
RSpec.describe Person, type: :model do
  it 'is valid with valid attributes' do
    person = build(:person)
    expect(person).to be_valid
  end
end
```

### Request Specs
```ruby
RSpec.describe 'People', type: :request do
  it 'returns a list of people' do
    get '/people'
    expect(response).to have_http_status(:ok)
  end
end
```

## FactoryBot

We use FactoryBot for test data generation instead of fixtures:

```ruby
# Create a person with all fields
person = create(:person)

# Create a person with only required fields
person = create(:minimal_person)

# Create a person with only email
person = create(:person_with_email_only)
```

## Why RSpec?

- **Better syntax** - More readable and expressive
- **Better organization** - Nested describes and contexts
- **Better matchers** - More powerful expectation syntax
- **Better debugging** - Better error messages and output
- **Industry standard** - Widely used in the Ruby community 