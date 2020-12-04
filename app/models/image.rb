class Image < ApplicationRecord
  belongs_to :imageable , polymorphic: true#, inverse_of: :images
  has_one_attached :image
end
