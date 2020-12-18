class Language < ApplicationRecord
  has_many :user_languages
  has_many :topic_translations
  has_many :users, through: :user_languages

  validates :name, uniqueness: true, presence: true
end
