class Topic < ApplicationRecord
  has_many :topic_translations

  validates :description, presence: true
end
