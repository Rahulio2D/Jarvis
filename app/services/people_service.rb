class PeopleService
  def self.find_by_uid(uid)
    Person.find_by(uid:)
  end
end
