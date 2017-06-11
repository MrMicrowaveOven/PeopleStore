class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :numbers
      t.string :wantToDelete
      t.string :yesIReallyWantToDeleteAll

      t.timestamps
    end
  end
end
