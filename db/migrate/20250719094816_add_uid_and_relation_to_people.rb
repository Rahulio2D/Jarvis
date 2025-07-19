class AddUidAndRelationToPeople < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :uid, :string, null: false
    add_column :people, :relation, :string
    
    add_index :people, :uid, unique: true
  end
end
