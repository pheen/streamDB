require 'spec_helper'
require './lib/vimeo_scrapper.rb'
require 'nokogiri'
require 'vimeo'

module Scrape
  describe VimeoScrapper do
    context '#video_info' do
      let(:node) { Nokogiri::HTML.parse('<embed src="http://vimeo.com/85056902"></embed>') }
      let(:info) { VimeoScrapper.find_info(node) }

      it 'should return a hash of attributes' do
        expect(info).to eq({
          title: "TIME LAPSE - Clouds (Video Test)", 
          direct_url: "https://player.vimeo.com/video/85056902", 
          thumbnail: "http://b.vimeocdn.com/ts/462/206/462206531_640.jpg", 
          post_date: DateTime.new(2014, 1, 25, 21, 02, 24)
        })
      end
    end
  end
end
