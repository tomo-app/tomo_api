class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :start_date_time, :limit => 8
      t.integer :end_date_time, :limit => 8
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
