require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'validations' do
    describe 'name' do
      it 'is valid with a name' do
        person = build(:person, :with_email)
        expect(person).to be_valid
      end
      
      it 'is invalid without a name' do
        person = build(:person, :with_email, name: nil)
        expect(person).not_to be_valid
        expect(person.errors[:name]).to include("can't be blank")
      end
      
      it 'is invalid with an empty name' do
        person = build(:person, :with_email, name: '')
        expect(person).not_to be_valid
        expect(person.errors[:name]).to include("can't be blank")
      end
    end
    
    describe 'relation' do
      it 'is valid with a relation' do
        person = build(:person, :with_email, relation: "Friend")
        expect(person).to be_valid
      end
      
      it 'is invalid without a relation' do
        person = build(:person, :with_email, relation: nil)
        expect(person).not_to be_valid
        expect(person.errors[:relation]).to include("must be one of the following: Friend, Mother, Father, Sister, Brother, Son, Daughter, Wife, Uncle, Aunt, Colleague, Other")
      end
      
      it 'is invalid with an empty relation' do
        person = build(:person, :with_email, relation: '')
        expect(person).not_to be_valid
        expect(person.errors[:relation]).to include("must be one of the following: Friend, Mother, Father, Sister, Brother, Son, Daughter, Wife, Uncle, Aunt, Colleague, Other")
      end
    end
    
    describe 'date_of_birth' do
      it 'is valid with a date of birth' do
        person = build(:person, :with_email, :with_dob, date_of_birth: Date.new(1990, 1, 1))
        expect(person).to be_valid
      end
      
      it 'is valid without a date of birth' do
        person = build(:person, :with_email, date_of_birth: nil)
        expect(person).to be_valid
      end
    end
    
    describe 'contact methods' do
      it 'is valid with both email and phone number' do
        person = build(:person, :with_email, :with_phone)
        expect(person).to be_valid
      end
      
      it 'is valid with only email' do
        person = build(:person, :with_email)
        expect(person).to be_valid
      end
      
      it 'is valid with only phone number' do
        person = build(:person, :with_phone)
        expect(person).to be_valid
      end
      
      it 'is invalid without both email and phone number' do
        person = build(:person, email: nil, phone_number: nil)
        expect(person).not_to be_valid
        expect(person.errors[:base]).to include("At least one contact method (phone number or email) must be provided")
      end
      
      it 'is invalid with empty email and phone number' do
        person = build(:person, email: '', phone_number: '')
        expect(person).not_to be_valid
        expect(person.errors[:base]).to include("At least one contact method (phone number or email) must be provided")
      end
    end
  end
  
  describe 'callbacks' do
    describe 'uid generation' do
      it 'generates a unique uid on creation' do
        person = create(:person, :with_email)
        expect(person.uid).to be_present
        expect(person.uid.length).to eq(36)
      end
    end
  end
end 