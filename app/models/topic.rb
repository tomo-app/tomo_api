class Topic < ApplicationRecord
  has_many :topic_translations, dependent: :destroy

  validates :description, presence: true

  def self.random
    Topic.order('RANDOM()').first
  end
end
