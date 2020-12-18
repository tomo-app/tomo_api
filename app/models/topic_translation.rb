class TopicTranslation < ApplicationRecord
  belongs_to :topic
  belongs_to :language

  validates :translation, presence: true
end
