class StreamsController < ApplicationController
  before_filter :set_current_user

  def index
  end

  def stream_list
    render json: {
      new_streams: new_streams,
      old_streams: old_streams
    }
  end

  def track_play
    stat = Play.find_or_initialize_by(user_id: @current_user.id, video_id: params[:stream_id])
    stat.play_count = (stat.play_count || 0) + 1
    stat.save
    render json: stat
  end

  def update_streams
    UpdateStreams.new.async.perform([:snow, :skate, :surf])
    #UpdateStreams.new.perform([:snow, :skate, :surf])

    render json: {
      queued: 'Snow, skate, and surf videos are being updated'
    }
  end

private

  def sports_list
    ['snow', 'skate', 'surf']
  end

  def new_streams
    recent_streams = sports_list.each_with_object({}) do |sport, hsh|
      hsh[sport] = Video.recent(sport)
    end

    plays = Play.where(user_id: @current_user.id, video_id: recent_streams.values.flatten)
    plays = plays.pluck(:video_id, :play_count).each_with_object({}) do |(video_id, play_count), hsh|
      hsh[video_id] = play_count
    end

    recent_streams.each do |sport, streams|
      recent_streams[sport] = streams.map do |stream|
        s = stream.attributes.merge({
          play_count: plays.fetch(stream.id) { 0 },
          url: stream['direct_url'] || stream['post_url']
        })

        s[:play_count] == 0 ? s : nil
      end.compact
    end
  end

  def old_streams
    arr   = Play.where(user_id: @current_user.id).pluck(:video_id, :play_count)
    plays = arr.each_with_object({}) do |(video_id, play_count), hsh|
      hsh[video_id] = play_count
    end

    streams = Video.where(id: plays.keys).map(&:attributes)
    streams.each do |stream|
      stream['play_count'] = plays[stream['id']]
      stream['url']        = stream['direct_url'] || stream['post_url']
    end

    streams.group_by do |stream|
      stream['sport']
    end
  end

  def plays_by_user(streams)
    Play.where(user_id: @current_user.id, video_id: (streams))
  end
end
