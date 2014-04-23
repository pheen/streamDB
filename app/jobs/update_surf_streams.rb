require 'robot'

class UpdateSurfStreams
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  def perform
    sports = [:surf]

    ActiveRecord::Base.connection_pool.with_connection do
      Robot.scrape(sports)
    end
  end

end
