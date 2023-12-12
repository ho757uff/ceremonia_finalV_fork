class Album < ApplicationRecord
    belongs_to :event
    has_many :images

    has_one_attached :cover_image
    has_many_attached :images
    
end
