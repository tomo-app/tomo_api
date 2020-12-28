class CreatePairings < ActiveRecord::Migration[6.1]
  def change
    create_table :pairings do |t|
      t.integer :date_time
      t.boolean :cancelled?

      t.timestamps
    end
  end
end
