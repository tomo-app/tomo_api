class Topic < ApplicationRecord
  has_many :topic_translations, dependent: :destroy

  validates :description, presence: true

  def self.random
    Topic.order('RANDOM()').first
  end

  def translations_for_languages(language_ids)
    topic_translations.where(language_id: language_ids[0]).or(topic_translations.where(language_id: language_ids[1]))
  end
end
