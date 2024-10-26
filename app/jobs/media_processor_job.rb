class MediaProcessorJob < ApplicationJob
  queue_as :default

  retry_on ActiveStorage::IntegrityError, attempts: 3, wait: 5.seconds
  retry_on Errno::ENOSPC, attempts: 3, wait: 10.seconds
  discard_on ActiveJob::DeserializationError

  def perform(attachment)
    case attachment.content_type
    when /^image\//
      process_image(attachment)
    when /^video\//
      process_video(attachment)
    else
      Rails.logger.error "Unsupported media type: #{attachment.content_type}"
    end
  end

  private

  def process_image(image)
    ImageProcessorJob.perform_now(image)
  end

  def process_video(video)
    VideoProcessorJob.perform_now(video)
  end
end
