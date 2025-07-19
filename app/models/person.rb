class Person < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :date_of_birth, presence: false, allow_nil: true

  # Custom validation to ensure at least one contact method is present
  validate :at_least_one_contact_method
  validate :valid_relation

  # Callbacks
  before_validation { self.uid = SecureRandom.uuid }

  VALID_RELATIONS = [ 'Friend', 'Mother', 'Father', 'Sister', 'Brother', 'Son', 'Daughter', 'Wife', 'Uncle', 'Aunt', 'Colleague', 'Other' ]

  private

  def at_least_one_contact_method
    if phone_number.blank? && email.blank?
      errors.add(:base, 'At least one contact method (phone number or email) must be provided')
    end
  end

  def valid_relation
    if relation.blank? || !VALID_RELATIONS.include?(relation)
      errors.add(:relation, "must be one of the following: #{VALID_RELATIONS.join(", ")}")
    end
  end
end
