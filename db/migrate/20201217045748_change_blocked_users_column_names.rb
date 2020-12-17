class ChangeBlockedUsersColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocked_pairings, :blocking_user_id, :user_id
    rename_column :blocked_pairings, :blocked_user_id, :blocked_pairing_id
  end
end
