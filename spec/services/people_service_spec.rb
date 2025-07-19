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
end
