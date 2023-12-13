class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  has_many :user_events
  has_many :roles, through: :user_events
  has_many :events, through: :user_events
  
  scope :guests, ->(event) { joins(:user_events).where(user_events: { event_id: event.id, role_id: 2 }) }

after_create :welcome_send
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  has_one_attached :avatar

  has_many :comments

  # def password_reset
  #   UserMailer.password_reset(self).deliver_now
  # end

  # has_one_attached :avatar
  # has_one :guest_list
  # has_one :menu
  # has_one :wishlist
  # has_many :photos
  # has_one :guest_book
  # has_one :fund


  def organizer?
    roles.exists?(role_name: "organizer")
  end
end