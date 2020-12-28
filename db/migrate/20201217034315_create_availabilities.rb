class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :start_date_time
      t.integer :end_date_time
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
