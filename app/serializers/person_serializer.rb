class PersonSerializer
  include JSONAPI::Serializer
  
  set_type :people
  set_id :uid
  
  attributes :name, :email, :phone_number, :date_of_birth, :relation
end
