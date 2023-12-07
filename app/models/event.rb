class Event < ApplicationRecord
    has_many :event_locations
    has_many :locations, through: :event_locations
    has_many :user_events
    has_many :users, through: :user_events
    has_many :roles, through: :user_events

    def organizer?(current_user)
      user_events.exists?(role_id: 1, user_id: current_user.id)
    end
end
