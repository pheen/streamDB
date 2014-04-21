require 'robot'

class UpdateStreams
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  def perform
    sports = [:snow, :surf, :skate]

    ActiveRecord::Base.connection_pool.with_connection do
      Robot.scrape(sports)
    end
  end

end
