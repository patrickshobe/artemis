class EpisodeUpdater
  def initialize(episode)
    @episode = episode
    @id = episode.series.id
  end

  def self.update(episode)
    updater = new(episode)
    updater.send_api_update
    updater.wait_for_job_success
    sleep 30
    updater.update_db
  end

  def update_db
    EpisodeBuilder.update_episode(@episode)
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
