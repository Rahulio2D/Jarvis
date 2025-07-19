# Code Quality with RuboCop

This project uses RuboCop to maintain consistent code style and quality across the codebase.

## Configuration

### RuboCop Configuration Files

- **`.rubocop.yml`** - Main configuration file with custom rules
- **`.rubocop_todo.yml`** - Temporarily disabled rules (auto-generated)

### Key Configuration Features

- **Rails Omakase** - Uses Rails-specific RuboCop rules
- **Single quotes** - Enforced for strings without interpolation
- **Line length** - 120 characters max (120 for specs)
- **Method length** - 20 lines max
- **Class length** - 150 lines max
- **ABC complexity** - 30 max

## Available Commands

### Basic Linting
```bash
# Check code style
make lint

# Quick alias
make l
```

### Auto-fixing
```bash
# Fix safe offenses automatically
make lint-fix

# Fix all offenses (including unsafe)
make lint-fix-all
```

### Configuration Management
```bash
# Generate todo file for existing violations
make lint-todo
```

## RuboCop Rules

### Style Guidelines

- **String literals**: Use single quotes unless interpolation needed
- **Array/Symbol literals**: Use `%w[]` and `%i[]` syntax
- **Line length**: 120 characters maximum
- **Method length**: 20 lines maximum
- **Class length**: 150 lines maximum

### Rails-Specific Rules

- **Rails/FilePath**: Use arguments instead of string concatenation
- **Rails/TimeZone**: Enforce timezone awareness
- **Rails/ApplicationRecord**: Use ApplicationRecord as base class

### Excluded Files

The following directories are excluded from RuboCop checks:
- `db/**/*` - Database files
- `config/**/*` - Configuration files
- `script/**/*` - Scripts
- `bin/**/*` - Binary files
- `vendor/**/*` - Vendor files
- `node_modules/**/*` - Node modules
- `tmp/**/*` - Temporary files
- `storage/**/*` - Storage files
- `log/**/*` - Log files
- `public/**/*` - Public assets

## Integration with Development Workflow

### Pre-commit Checks
Before committing code, run:
```bash
make lint
make test
```

### CI Integration
RuboCop is integrated into the CI pipeline and will fail builds if violations are found.

### IDE Integration
Most IDEs support RuboCop integration:
- **VS Code**: Install Ruby and RuboCop extensions
- **RubyMine**: Built-in RuboCop support
- **Vim/Neovim**: Use ALE or similar plugins

## Common RuboCop Offenses and Fixes

### String Literals
```ruby
# Bad
name = "John Doe"

# Good
name = 'John Doe'
```

### Array Literals
```ruby
# Bad
relations = ["Friend", "Family", "Colleague"]

# Good
relations = %w[Friend Family Colleague]
```

### Symbol Arrays
```ruby
# Bad
platforms = [:windows, :jruby]

# Good
platforms = %i[windows jruby]
```

### Line Length
```ruby
# Bad - Line too long
def create_person_with_very_long_parameters(name, email, phone_number, date_of_birth, relation, uid)

# Good - Break into multiple lines
def create_person_with_very_long_parameters(
  name, email, phone_number, date_of_birth, relation, uid
)
```

## Disabling RuboCop

### For a Single Line
```ruby
# rubocop:disable Style/StringLiterals
name = "John Doe"  # This line is ignored
# rubocop:enable Style/StringLiterals
```

### For a Method
```ruby
# rubocop:disable Metrics/MethodLength
def very_long_method
  # ... long method body
end
# rubocop:enable Metrics/MethodLength
```

### For a File
```ruby
# rubocop:disable all
# This entire file is ignored by RuboCop
```

## Best Practices

1. **Run RuboCop regularly** - Use `make lint` before committing
2. **Fix violations promptly** - Don't let them accumulate
3. **Use auto-fix when safe** - `make lint-fix` handles most issues
4. **Review unsafe fixes** - Always check changes from `make lint-fix-all`
5. **Update todo file** - Regenerate when adding new violations
6. **Document exceptions** - Add comments when disabling RuboCop

## Troubleshooting

### Common Issues

**RuboCop not found**: Run `bundle install` to install dependencies

**Configuration errors**: Check `.rubocop.yml` syntax

**Performance issues**: Exclude large directories in configuration

**False positives**: Use inline comments to disable specific rules

### Getting Help

- **RuboCop documentation**: https://docs.rubocop.org/
- **Rails Omakase**: https://github.com/rails/rubocop-rails-omakase
- **Community**: Ruby/Rails community forums and Slack channels 