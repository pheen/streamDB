# Ensure the jobs run only in a web server.
if defined?(Rails::Server)
  FistOfFury.attack! do
    # Jobs can be scheduled here. Example:
    # SayHiJob.recurs { secondly(3) }

    UpdateSnowStreams.recurs  { minutely(60) }
    UpdateSkateStreams.recurs { minutely(70) }
    UpdateSurfStreams.recurs  { minutely(80) }
  end

  Rails.logger.info "Updating Snow Streams"
  UpdateSnowStreams.new.async.perform
  Rails.logger.info "Updating Skate Streams"
  UpdateSkateStreams.new.async.perform
  Rails.logger.info "Updating Surf Streams"
  UpdateSurfStreams.new.async.perform
end
