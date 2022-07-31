class CreateChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :choices, comment: :選択肢 do |t|
      t.string :body, null: false, comment: :本文
      t.boolean :is_correct, comment: :正解の選択肢か
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
    add_index :choices, [:quiz_id, :body], unique: true
  end
end
