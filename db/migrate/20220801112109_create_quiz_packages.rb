class CreateQuizPackages < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_packages, comment: :クイズパッケージ do |t|
      t.integer :position, null: false, comment: :表示順位
      t.references :quiz, null: false, foreign_key: true
      t.references :choice, foreign_key: true
      t.references :package, null: false, foreign_key: true

      t.timestamps
    end
    add_index :quiz_packages, [:package_id, :position], unique: true
  end
end
