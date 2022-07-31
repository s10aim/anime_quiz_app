class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes, comment: :クイズ do |t|
      t.text :question, null: false, comment: :質問
      t.text :description, comment: :説明
      t.integer :status, default: 0, null: false, comment: :ステータス
      t.datetime :published_at, comment: :公開日時
      t.references :user, null: false, foreign_key: true
      t.references :anime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
