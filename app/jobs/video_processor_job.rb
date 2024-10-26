class VideoProcessorJob < ApplicationJob
  queue_as :default

  def perform(video)
    tempfile = video.download
    output = Tempfile.new([ video.filename.base, ".mp4" ])

    compress_video(tempfile.path, output.path)

    video.purge
    video.attach(io: File.open(output.path), filename: video.filename.to_s, content_type: "video/mp4")
  ensure
    tempfile&.close
    tempfile&.unlink
    output&.close
    output&.unlink
  end

  private

  def compress_video(input_path, output_path)
    movie = FFMPEG::Movie.new(input_path)
    options = { video_codec: "libx264", audio_codec: "aac",
                custom: "-crf 23 -preset medium -movflags +faststart" }

    movie.transcode(output_path, options)
  end
end
