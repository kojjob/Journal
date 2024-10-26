require "image_processing/mini_magick"

class ImageProcessorJob < ApplicationJob
  queue_as :default

  def perform(image)
    processed_image = ImageProcessing::MiniMagick
      .source(image.download)
      .resize_to_limit(800, 800)
      .call

    image.purge
    image.attach(io: File.open(processed_image.path), filename: image.filename.to_s, content_type: image.content_type)
  ensure
    processed_image&.close
    processed_image&.unlink
  end
end
