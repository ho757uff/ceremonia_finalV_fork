class Event < ApplicationRecord
    has_many :event_locations
    has_many :locations, through: :event_locations
    has_many :user_events
    has_many :users, through: :user_events
    has_many :roles, through: :user_events
end
