class Language < ApplicationRecord
  has_many :user_languages, dependent: :destroy
  has_many :topic_translations, dependent: :destroy
  has_many :users, through: :user_languages

  validates :name, uniqueness: true, presence: true
end
