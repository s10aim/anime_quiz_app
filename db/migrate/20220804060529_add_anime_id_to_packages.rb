class AddAnimeIdToPackages < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :anime, foreign_key: true
  end
end
