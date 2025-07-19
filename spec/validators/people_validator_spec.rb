require 'rails_helper'

RSpec.describe PeopleValidator do
  let(:valid_params) do
    {
      name: 'John Doe',
      phone_number: '+1-555-123-4567',
      email: 'john@example.com',
      date_of_birth: '1990-01-01',
      relation: 'Friend'
    }
  end
  let(:params) { valid_params }

  subject { described_class.new.call(params) }

  RSpec.shared_examples 'a successful validation' do
    it 'is successful' do
      expect(subject).to be_success
    end
  end

  RSpec.shared_examples 'a failed validation' do |field, error_message|
    it 'is not successful' do
      expect(subject).to be_failure
      expect(subject.errors[field]).to include(error_message)
    end
  end

  context 'with valid parameters' do
    it_behaves_like 'a successful validation'
  end

  context 'name validation' do
    let(:params) { valid_params.except(:name) }

    it_behaves_like 'a failed validation', :name, 'is missing'

    context 'when name is too short' do
      let(:params) { valid_params.merge(name: 'A') }

      it_behaves_like 'a failed validation', :name, 'must be at least 2 characters long'
    end
  end

  context 'phone number validation' do
    context 'when phone number is valid' do
      valid_phones = [
        '+1-555-123-4567',
        '(555) 123-4567',
        '555.123.4567',
        '555 123 4567',
        '+44 20 7946 0958'
      ]

      valid_phones.each do |phone|
        let(:params) { valid_params.merge(phone_number: phone) }

        it_behaves_like 'a successful validation'
      end
    end

    context 'when phone number is invalid' do
      invalid_phones = [
        'abc123',
        '555-123-4567!',
        '555@123#4567'
      ]
      invalid_phones.each do |phone|
        let(:params) { valid_params.merge(phone_number: phone) }

        it_behaves_like 'a failed validation', :phone_number, 'must contain only digits, spaces, hyphens, plus signs, parentheses, and dots'
      end
    end

    context 'when phone number is not present' do
      let(:params) { valid_params.except(:phone_number) }

      it_behaves_like 'a successful validation'
    end
  end

  context 'email validation' do
    context 'when email is valid' do
      valid_emails = [
        'user@example.com',
        'user.name@example.co.uk',
        'user+tag@example.org'
      ]
      valid_emails.each do |email|
        let(:params) { valid_params.merge(email: email) }

        it_behaves_like 'a successful validation'
      end
    end

    context 'when email is invalid' do
      invalid_emails = [
        'invalid-email',
        '@example.com',
        'user@',
        'user..name@example.com'
      ]
      invalid_emails.each do |email|
        let(:params) { valid_params.merge(email: email) }

        it_behaves_like 'a failed validation', :email, 'must be a valid email address'
      end
    end

    context 'when email is not present' do
      let(:params) { valid_params.except(:email) }

      it_behaves_like 'a successful validation'
    end
  end

  context 'date of birth validation' do
    context 'when date of birth is valid' do
      let(:params) { valid_params.merge(date_of_birth: '1990-01-01') }

      it_behaves_like 'a successful validation'
    end

    context 'when date of birth is in the future' do
      let(:params) { valid_params.merge(date_of_birth: (Date.current + 1.day).to_s) }

      it_behaves_like 'a failed validation', :date_of_birth, 'cannot be in the future'
    end

    context 'when date of birth is too far in the past' do
      let(:params) { valid_params.merge(date_of_birth: (Date.current - 101.years).to_s) }

      it_behaves_like 'a failed validation', :date_of_birth, 'cannot be more than 100 years ago'
    end

    context 'when date of birth is not present' do
      let(:params) { valid_params.except(:date_of_birth) }

      it_behaves_like 'a successful validation'
    end
  end

  context 'relation validation' do
    context 'when relation is present' do
      let(:params) { valid_params.merge(relation: 'Friend') }

      it_behaves_like 'a successful validation'
    end

    context 'when relation is valid' do
      Person::VALID_RELATIONS.each do |relation|
        let(:params) { valid_params.merge(relation: relation) }

        it_behaves_like 'a successful validation'
      end
    end

    context 'when relation is invalid' do
      let(:params) { valid_params.merge(relation: 'InvalidRelation') }

      it_behaves_like 'a failed validation', :relation, "must be one of the following: #{Person::VALID_RELATIONS.join(', ')}"
    end
  end

  context 'contact method validation' do
    context 'when at least one contact method is present' do
      let(:params) { valid_params.except(:phone_number, :email) }

      it_behaves_like 'a failed validation', :base, 'at least one contact method (phone number or email) must be provided'
    end

    context 'when only phone number is provided' do
      let(:params) { valid_params.except(:email) }

      it_behaves_like 'a successful validation'
    end

    context 'when only email is provided' do
      let(:params) { valid_params.except(:phone_number) }

      it_behaves_like 'a successful validation'
    end
  end
end
