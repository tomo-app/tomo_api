class ChangeUserPairingsToPairingUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_pairings, :pairings_users
  end
end
