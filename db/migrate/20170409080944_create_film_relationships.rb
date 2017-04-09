class CreateFilmRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :film_relationships do |t|
      t.integer :film_id
      t.integer :user_id

      t.timestamps
    end
  end
end
