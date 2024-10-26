class Journal < ApplicationRecord
  has_many_attached :images
  has_many_attached :videos
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :published_at, presence: true

  belongs_to :category, optional: true  # optional if a journal might not belong to a category


  after_create_commit :process_media

  validate :validate_images
  validate :validate_videos

  scope :with_attachments, -> { with_attached_images.with_attached_videos }
  scope :recent, -> { order(published_at: :desc) }

  MAX_IMAGE_SIZE = 10.megabyte
  MAX_VIDEO_SIZE = 500.megabytes
  ALLOWED_IMAGE_TYPES = %w[image/jpeg image/png].freeze
  ALLOWED_VIDEO_TYPES = %w[video/mp4 video/quicktime video/webm].freeze

  private

  def validate_images
    return unless images.attached?

    images.each do |image|
      if image.blob.byte_size > MAX_IMAGE_SIZE
        errors.add(:images, "should be less than #{MAX_IMAGE_SIZE / 1.megabyte}MB")
      end

      unless ALLOWED_IMAGE_TYPES.include?(image.content_type)
        errors.add(:images, "must be JPEG or PNG oR WEBM")
      end
    end
  end

  def validate_videos
    return unless videos.attached?

    videos.each do |video|
      if video.blob.byte_size > MAX_VIDEO_SIZE
        errors.add(:videos, "should be less than #{MAX_VIDEO_SIZE / 1.megabyte}MB")
      end

      unless ALLOWED_VIDEO_TYPES.include?(video.content_type)
        errors.add(:videos, "must be MP4 or MOV  or WEBM")
      end
    end
  end

  # Add this method for debugging
  def log_validation_errors
    if errors.any?
      Rails.logger.error "Journal validation failed. Errors: #{errors.full_messages}"
      Rails.logger.error "Journal attributes: #{attributes.inspect}"
    end
  end

  # Call this method after validations
  after_validation :log_validation_errors

  def process_media
    images.each { |image| MediaProcessorJob.perform_later(image) }
    videos.each { |video| MediaProcessorJob.perform_later(video) }
  end
end
