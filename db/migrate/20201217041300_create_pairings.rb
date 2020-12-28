class CreatePairings < ActiveRecord::Migration[6.1]
  def change
    create_table :pairings do |t|
      t.integer :date_time, :limit => 8
      t.boolean :cancelled?

      t.timestamps
    end
  end
end
