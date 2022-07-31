class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages, comment: :パッケージ do |t|
      t.integer :category, null: false, comment: :カテゴリー
      t.string :guest_id, comment: :ゲストID
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
