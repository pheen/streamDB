# Ensure the jobs run only in a web server.
if defined?(Rails::Server)
  FistOfFury.attack! do
    # Jobs can be scheduled here. Example:
    # SayHiJob.recurs { secondly(3) }

    UpdateSnowStreams.recurs  { minutely(60) }
    UpdateSkateStreams.recurs { minutely(70) }
    UpdateSurfStreams.recurs  { minutely(80) }
  end
end
