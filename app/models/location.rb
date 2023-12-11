class Location < ApplicationRecord
  has_many :event_locations
  has_many :events, through: :event_locations
  
  enum privacy_status: { location_private: 0, location_public: 1 }, _default: :location_private
  accepts_nested_attributes_for :event_locations
end
