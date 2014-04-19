class StreamsController < ApplicationController
  before_filter :set_current_user

  def index
  end

  def stream_list
    render json: {
      snowStreams:  snow_streams,
      skateStreams: skate_streams,
      surfStreams: surf_streams,
      plays: plays
    }
  end

  def track_play
    stat = Play.find_or_initialize_by(user_id: @current_user.id, video_id: params[:stream_id])
    stat.play_count = (stat.play_count || 0) + 1
    stat.save
    render json: stat
  end

  def update_streams
    #UpdateStreams.new.async.perform([:snow, :skate, :surf])
    UpdateStreams.new.perform([:snow, :skate, :surf])

    render json: {
      queued: 'Snow, skate, and surf videos are being updated'
    }
  end

private

  def snow_streams
    @snow_streams ||= Video.where(sport: 'snow').order('created_at DESC').first(28)
  end

  def skate_streams
    @skate_streams ||= Video.where(sport: 'skate').order('created_at DESC').first(28)
  end

  def surf_streams
    @surf_streams ||= Video.where(sport: 'surf').order('created_at DESC').first(28)
  end

  def plays
    @plays ||= Play.where(user_id: @current_user.id, video_id: (snow_streams + skate_streams))
  end
end
