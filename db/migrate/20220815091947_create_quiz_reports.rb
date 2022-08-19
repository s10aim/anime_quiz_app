class CreateQuizReports < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_reports, comment: :クイズ報告 do |t|
      t.text :reason, null: false, comment: :理由
      t.integer :status, default: 0, null: false, comment: :ステータス
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
