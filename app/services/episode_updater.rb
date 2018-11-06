class EpisodeUpdater
  def initialize(series_id)
    @id = series_id
  end

  def self.update(series_id)
    updater = new(series_id)
    updater.send_api_update
    updater.wait_for_job_success
    updater.update_db
  end


  def get_update
    si = SonarrInterface.new()
  end

  def update_db
    binding.pry
    EpisodeBuilder.update_episode(@id)
  end

  def send_api_update
    si = SonarrInterface.new
    si.post(build_post_body)
  end

  def build_post_body
    {
      'name'     => 'RescanSeries',
      'seriesId' => @id
    }.to_json
  end

  def check_job_status
    wait_for_job_success
  end

  def wait_for_job_success
    successful = false
    runs = 0
    while successful != false && runs < 16
      successful = validate_empty_job_queue
      runs += 1
      sleep 1
    end
  end

  def validate_empty_job_queue
    si = SonarrInterface.new()
    status = si.get(:command)
    true unless status.any?
  end
end
