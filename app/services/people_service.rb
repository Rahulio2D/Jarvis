class PeopleService
  def self.find_by_uid(uid)
    Person.find_by(uid:)
  end

  def self.create(params)
    validation_result = PeopleValidator.new.call(params)

    if validation_result.success?
      Person.create!(params)
    else
      { errors: validation_result.errors.to_h }
    end
  end
end
