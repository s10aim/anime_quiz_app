class RemoveRecoverableFromAdmins < ActiveRecord::Migration[7.0]
  def change
    remove_index  :admins, :reset_password_token, unique: true
    remove_column :admins, :reset_password_token, :string
    remove_column :admins, :reset_password_sent_at, :datetime
  end
end
