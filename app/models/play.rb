class Play < ActiveRecord::Base

  belongs_to :video
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :video_id

  def self.by(user)
    find_by_user_id(user) || None.new
  end

  after_initialize do
    # does this even work?
    # todo: move default to db
    if self.new_record?
      self.play_count = 0
    end
  end

  class None
    attr_accessor :play_count

    def initialize
      @play_count = 0
    end
  end
end
