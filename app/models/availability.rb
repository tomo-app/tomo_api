class Availability < ApplicationRecord
  belongs_to :user

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true
  validates :status, presence: true

  enum status: { 'open': 0, 'fulfilled': 1, 'cancelled': 2 }

  def availabilities_to_pair
    return [] if people_to_pair.empty?

    Availability.where(start_date_time: start_date_time..end_date_time)
                .or(Availability.where(end_date_time: start_date_time..end_date_time))
                .or(Availability.where('availabilities.start_date_time < ?', start_date_time).where(
                      'availabilities.end_date_time > ?', end_date_time
                    ))
                .where.not(user_id: user_id)
                .where.not(user_id: user.blocked_ids)
                .where(status: 'open').where(user_id: people_to_pair.first.user_id)
  end

  def people_to_pair
    target = user.user_languages.find_by(fluency_level: 'target')
    native = user.user_languages.find_by(fluency_level: 'native')

    target_users = UserLanguage.where.not(user_id: user_id).where(fluency_level: 'native',
                                                                  language_id: target.language_id).select(:user_id)
    UserLanguage.where.not(user_id: user_id)
                .where(fluency_level: 'target', language_id: native.language_id)
                .where(user_id: target_users).order(:created_at)
  end
end
