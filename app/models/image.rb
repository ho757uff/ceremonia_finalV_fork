class Image < ApplicationRecord
    belongs_to :user
    belongs_to :album
    has_many :comments, dependent: :destroy
    has_one_attached :image
end
