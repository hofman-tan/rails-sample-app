class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image   # Active Storage API
  # stabby lambda "->" takes in a block and returns a Proc (procedure) or lambda, which is an anonymous function
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }

  has_many :likes, dependent: :destroy
                                      
  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end