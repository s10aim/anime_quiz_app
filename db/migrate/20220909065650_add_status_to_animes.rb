class AddStatusToAnimes < ActiveRecord::Migration[7.0]
  def change
    add_column :animes, :status, :integer, default: 0, null: false, comment: :ステータス
  end
end
