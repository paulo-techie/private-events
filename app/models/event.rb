class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee

  scope :past, -> { where('time < ?', Time.now) }
  scope :upcoming, -> { where('time >= ?', Time.now) }
end
