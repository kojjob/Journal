class Journal < ApplicationRecord
has_many_attached :images
  has_many_attached :videos

  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :published_at, presence: true

  # validate :validate_image_type
  # validate :validate_video_type
  #
  private

  def validate_image_type
    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png])
        errors.add(:images, "must be JPEG or PNG")
      end
    end
  end

  def validate_video_type
    videos.each do |video|
      unless video.content_type.in?(%w[video/mp4 video/quicktime])
        errors.add(:videos, "must be MP4 or MOV")
      end
    end
  end
end
