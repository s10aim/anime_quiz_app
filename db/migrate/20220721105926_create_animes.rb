class CreateAnimes < ActiveRecord::Migration[7.0]
  def change
    create_table :animes, comment: :アニメ do |t|
      t.string :title, null: false, comment: :タイトル

      t.timestamps
    end
    add_index :animes, :title, unique: true
  end
end
