class AddResultColumnsToPackages < ActiveRecord::Migration[7.0]
  def change
    change_table :packages, bulk: true do |t|
      t.datetime :start_at, null: false, default: -> { 'NOW()' }, comment: :開始時刻
      t.datetime :finished_at, comment: :終了時刻
      t.integer :quiz_score, comment: :クイズスコア
      t.integer :ranking_score, comment: :ランキングスコア
      t.integer :anime_list_count, comment: :アニメリストの数
    end
  end
end
