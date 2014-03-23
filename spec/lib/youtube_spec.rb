require 'spec_helper'
require './lib/youtube_scrapper.rb'
require 'youtube_it'

module Scrape
  describe YoutubeScrapper do
    context '#video_info' do
      let(:scrape) { YoutubeScrapper.new('.com/embed/ofwSz-eiOB0') }

      it 'should return a hash of attributes' do
        expect(scrape.video_info).to eq({
          title: 'Bear Mountain Opening Day Coming Soon!',
          direct_url: 'http://www.youtube.com/v/ofwSz-eiOB0?version=3&f=videos&d=AWN8MXHWgMqDJ_gE2QjNHPcO88HsQjpE1a8d1GxQnGDm&app=youtube_gdata',
          thumbnail: 'http://i1.ytimg.com/vi/ofwSz-eiOB0/hqdefault.jpg',
          post_date: Time.utc(2013, 10, 29, 19, 30, 07)
        })
      end
    end
  end
end
