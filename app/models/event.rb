class Event < ApplicationRecord
  before_destroy :cleanup_associations
  has_many :albums
  has_many :event_locations, dependent: :destroy
  has_many :locations, through: :event_locations
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :roles, through: :user_events

  has_rich_text :description
  has_rich_text :program

  validates :title, presence: true
  validates :date, presence: true


  def organizer?(current_user)
    user_events.exists?(role_id: 1, user_id: current_user.id)
  end
  

  private

  def cleanup_associations
    self.user_events.destroy_all
    self.event_locations.destroy_all
  end
end
