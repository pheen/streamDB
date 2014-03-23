module StreamsHelper
  def new?(stream)
    stream.plays_by(@current_user) == 0 ? 'new' : ''
  end
end
