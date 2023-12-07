class EventLocation < ApplicationRecord
    has_many :locations
    belongs_to :event
    has_many :users, through: :event
end
