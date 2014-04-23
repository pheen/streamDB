require 'robot'

class UpdateSnowStreams
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  def perform
    sports = [:snow]

    ActiveRecord::Base.connection_pool.with_connection do
      Robot.scrape(sports)
    end
  end

end
