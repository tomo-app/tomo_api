class ChangeAvailabilityDateDataType < ActiveRecord::Migration[6.1]
  def change
    change_table :availabilities do |t|
      t.remove :start_date_time, :end_date_time, :users_id
      t.references :user, null: false, foreign_key: true
      t.string :start_date_time
      t.string :end_date_time
    end
  end
end
