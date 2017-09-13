class DownWorker
  include Sidekiq::Worker

  def perform(link)
    download = open(link)
    @image_name = download.base_uri.to_s.split('/')[-1].sub(/\?.*$/, '')
    logger.debug @image_name
    logger.debug "#{Rails.root}/app/assets/images/#{@image_name}"
    IO.copy_stream(download, "#{Rails.root}/app/assets/images/#{@image_name}")
  end
end
