require 'robot'

class UpdateSkateStreams
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  def perform
    sports = [:skate]

    ActiveRecord::Base.connection_pool.with_connection do
      Robot.scrape(sports)
    end
  end

end
