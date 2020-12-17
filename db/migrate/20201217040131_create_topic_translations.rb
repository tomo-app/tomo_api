class CreateTopicTranslations < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_translations do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
      t.text :translation

      t.timestamps
    end
  end
end
