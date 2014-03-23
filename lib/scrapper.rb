require 'youtube_scrapper'
require 'vimeo_scrapper'

module Scrapper
  def self.find_info(node_set)
    result = [VimeoScrapper, YoutubeScrapper].map do |scrapper|
      scrapper.find_info(node_set)
    end

    result.reject do |scrapper|
      scrapper.empty?
    end
  end
end
