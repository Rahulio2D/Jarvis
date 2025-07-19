class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end
  end
end
