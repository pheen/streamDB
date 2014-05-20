require 'robot'

class Video < ActiveRecord::Base

  attr_accessor :play_count, :new

  validates_presence_of :title, :post_date, :post_url, :thumbnail, :sport
  validate :unique_urls

  has_many :plays

  scope :recent, ->(sport) { where(sport: sport).order('created_at DESC').first(40) }

  def self.update(*sports)
    Robot.scrape(*sports)
  end

private

  def unique_urls
    count = 0
    count += Video.where(:direct_url => direct_url).count if direct_url
    count += Video.where(:post_url => post_url).count if post_url
    errors.add(:base, 'URL already exists') unless count.zero?
  end

end
