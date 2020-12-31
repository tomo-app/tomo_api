class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language

  enum fluency_level: { 'native': 0, 'target': 1 }
end
