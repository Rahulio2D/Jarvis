class PeopleValidator < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    optional(:phone_number).maybe(:string)
    optional(:email).maybe(:string)
    optional(:date_of_birth).maybe(:date)
    required(:relation).filled(:string)
  end

  rule(:name) do
    if value.present? && value.length < 2
      key.failure('must be at least 2 characters long')
    end
  end

  rule(:phone_number) do
    if value.present?
      # Basic phone number validation - allows various formats
      unless value.match?(/\A[\d\s\-\+\(\)\.]+\z/)
        key.failure('must contain only digits, spaces, hyphens, plus signs, parentheses, and dots')
      end
    end
  end

  rule(:email) do
    if value.present?
      # More comprehensive email validation that rejects consecutive dots
      email_regex = /\A[\w+\-]+(\.[\w+\-]+)*@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      unless value.match?(email_regex)
        key.failure('must be a valid email address')
      end
    end
  end

  rule(:date_of_birth) do
    if value.present?
      if value > Date.current
        key.failure('cannot be in the future')
      end

      if value < Date.current - 100.years
        key.failure('cannot be more than 100 years ago')
      end
    end
  end

  rule(:relation) do
    unless Person::VALID_RELATIONS.include?(value)
      key.failure("must be one of the following: #{Person::VALID_RELATIONS.join(', ')}")
    end
  end

  rule(:phone_number, :email) do
    if values[:phone_number].blank? && values[:email].blank?
      key(:base).failure('at least one contact method (phone number or email) must be provided')
    end
  end
end
