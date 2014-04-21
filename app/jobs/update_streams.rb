class UpdateStreams
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  def perform(sites)
    ActiveRecord::Base.connection_pool.with_connection do
      Robot.scrape(sites)
    end
  end

end
