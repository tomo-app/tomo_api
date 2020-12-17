class ChangePairingUsersColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :pairings_users, :user_1_id, :user_id
    rename_column :pairings_users, :user_2_id, :pairing_id
  end
end
