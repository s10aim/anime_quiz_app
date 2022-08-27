class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes, comment: :いいね do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:quiz_id, :user_id], unique: true
  end
end
