class EventLocation < ApplicationRecord
    has_many :locations
    belongs_to :event
end
