class Topic < ApplicationRecord
  has_many :topic_translations, dependent: :destroy

  validates :description, presence: true
end
