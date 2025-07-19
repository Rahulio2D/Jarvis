require 'rails_helper'

RSpec.describe PersonSerializer do
  let(:person) { create(:person, :with_email, :with_phone, :with_dob) }
  let(:serializer) { described_class.new(person) }

  subject(:serialized) { serializer.serializable_hash }

  it 'includes all required attributes in the attributes object' do
    attributes = serialized[:data][:attributes]
    expect(attributes).to include(:name, :email, :phone_number, :date_of_birth, :relation)
  end

  it 'excludes timestamp attributes' do
    attributes = serialized[:data][:attributes]
    expect(attributes).not_to include(:created_at, :updated_at)
  end

  it 'serializes the expected response' do
    expect(serialized).to eq({
      data: {
        id: person.uid,
        type: :people,
        attributes: {
          name: person.name,
          email: person.email,
          phone_number: person.phone_number,
          date_of_birth: person.date_of_birth,
          relation: person.relation
        }
      }
    })
  end
end
