class CreatePairings < ActiveRecord::Migration[6.1]
  def change
    create_table :pairings do |t|
      t.references :user1, foreign_key: { to_table: :users }
      t.references :user2, foreign_key: { to_table: :users }
      t.integer :date_time, :limit => 8
      t.boolean :user1_cancelled?
      t.boolean :user2_cancelled?

      t.timestamps
    end
  end
end
