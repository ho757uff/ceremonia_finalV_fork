class User < ApplicationRecord
  has_many :user_events
  has_many :roles, through: :user_events
  has_many :events, through: :user_events
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def organizer?
    roles.exists?(role_name: 'organizer')
  end
end
