class CreateBlockedPairings < ActiveRecord::Migration[6.1]
  def change
    create_table :blocked_pairings do |t|
      t.references :blocking_user, foreign_key: { to_table: :users }
      t.references :blocked_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
