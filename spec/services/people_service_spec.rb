require 'rails_helper'

RSpec.describe PeopleService do
  describe '.find_by_uid' do
    let(:person) { create(:person, :with_email) }

    it 'returns the person when found' do
      result = described_class.find_by_uid(person.uid)
      expect(result).to eq(person)
    end

    context 'when the person is not found' do
      it 'returns nil' do
        result = described_class.find_by_uid('NONEXISTENT')
        expect(result).to be_nil
      end
    end

    context 'when the uid is nil' do
      it 'returns nil' do
        result = described_class.find_by_uid(nil)
        expect(result).to be_nil
      end
    end
  end

  describe '.create' do
    let(:valid_params) do
      {
        name: 'John Doe',
        phone_number: '1234567890',
        email: 'john.doe@example.com',
        date_of_birth: '1990-01-01',
        relation: 'Friend'
      }
    end

    it 'creates a new person' do
      result = described_class.create(valid_params)
      expect(result).to be_a(Person)
    end

    context 'when the params are invalid' do
      context 'when the params are missing a required field' do
        let(:invalid_params) { valid_params.except(:name) }

        it 'returns an error hash with the invalid field' do
          result = described_class.create(invalid_params)
          expect(result).to eq(
            {
              errors: {
                name: [ "is missing" ]
              }
            }
          )
        end
      end

      context 'when the params are empty' do
        let(:invalid_params) { {} }

        it 'returns an error hash with each field that is invalid' do
          result = described_class.create(invalid_params)
          expect(result).to eq(
            {
              errors: {
                base: [ "at least one contact method (phone number or email) must be provided" ],
                name: [ "is missing" ],
                relation: [ "is missing" ]
              }
            }
          )
        end
      end
    end
  end
end
