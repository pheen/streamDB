require 'robot'

class Video < ActiveRecord::Base
  validates_presence_of :title, :post_date, :post_url, :thumbnail, :sport
  validate :unique_urls

  has_many :plays

  def self.update(*sports)
    Robot.scrape(*sports)
  end

  def plays_by(user)
    stats = plays.by(user)
    stats.play_count
  end

  def unique_urls
    count = 0
    count += Video.where(:direct_url => direct_url).count if direct_url
    count += Video.where(:post_url => post_url).count if post_url
    errors.add(:base, 'URL already exists') unless count.zero?
  end

  def url
    direct_url || post_url
  end

  def direct_url?
    !direct_url.nil?
  end

end
