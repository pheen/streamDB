class StreamsController < ApplicationController
  before_filter :set_current_user, :fetch_streams

  def index
  end

private

  def fetch_streams
    @snow_streams = Video.where(sport: 'snow').last(7)
  end
end
