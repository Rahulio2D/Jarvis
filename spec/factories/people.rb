FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    relation { 'Friend' }
    
    # Factory for person with only email
    trait :with_email do
      email { Faker::Internet.email }
    end
    
    # Factory for person with only phone number
    trait :with_phone do
      phone_number { Faker::PhoneNumber.phone_number }
    end
    
    # Factory for person without date of birth
    trait :with_dob do
      date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    end
  end
end 