require './lib/sites.rb'
require 'spec_helper'

module Scrape::Sites
  describe TransworldSnow do
    describe 'scrape' do   
      context 'embedded youtube' do
        let(:api) { TransworldSnow.new('./spec/assets/tws_youtube_rss.xml') }

        it 'should return the title' do
          expect(api.scrape[:title]).to eq('Sunday In The Park 2014 Episode 7 - Bear Mountain - TransWorld SNOWboarding')
        end

        it 'should return the direct url' do
          expect(api.scrape[:direct_url]).to eq('http://www.youtube.com/v/EVU9aChB03Q?version=3&f=videos&d=AWN8MXHWgMqDJ_gE2QjNHPcO88HsQjpE1a8d1GxQnGDm&app=youtube_gdata')
        end

        it 'should return a thumbnail' do
          expect(api.scrape[:thumbnail]).to eq('http://i1.ytimg.com/vi/EVU9aChB03Q/hqdefault.jpg')
        end

        it 'should return the original post date' do
          expect(api.scrape[:post_date]).to eq(Time.utc(2014, 02, 02, 17, 30, 30))
        end
      end

      context 'embedded vimeo' do
        let(:api) { TransworldSnow.new('./spec/assets/tws_vimeo_rss.xml') }

        it 'should return the title' do
          expect(api.scrape[:title]).to eq('ISENSEVEN - DBK and Stephan Maurer in "A WAY WE GO"')
        end

        it 'should return the direct url' do
          expect(api.scrape[:direct_url]).to eq('https://player.vimeo.com/video/84697117')
        end

        it 'should return a thumbnail' do
          expect(api.scrape[:thumbnail]).to eq('http://b.vimeocdn.com/ts/461/663/461663134_640.jpg')
        end

        it 'should return the original post date' do
          expect(api.scrape[:post_date]).to eq(DateTime.new(2014, 01, 21, 12, 54, 00))
        end
      end

      context 'something is probably embedded but I can\'t find it' do
        let(:api) { TransworldSnow.new('./spec/assets/tws_rss.xml') }

        it 'should return the title' do
          expect(api.scrape[:title]).to eq('SIA 2014 Day Two Video Interviews')
        end

        it 'should return the post url' do
          expect(api.scrape[:post_url]).to eq('http://snowboarding.transworld.net/1000219960/videos/sia-2014-day-two-video-interviews/')
        end

        it 'should return a thumbnail' do
          expect(api.scrape[:thumbnail]).to eq('http://cdn.snowboarding.transworld.net/wp-content/blogs.dir/442/files/2014/02/Screen-Shot-2014-02-02-at-1.24.04-PM-600x334.png')
        end

        it 'should return the original post date' do
          expect(api.scrape[:post_date]).to eq(DateTime.new(2014, 02, 02, 21, 31, 25))
        end
      end
    end
  end

  describe SnowboarderMag do
    describe 'scrape' do
      context 'vimeo' do
        let(:api) { SnowboarderMag.new('./spec/assets/sbm_vimeo_rss.xml') }

        it 'should return the title' do
          expect(api.scrape[:title]).to eq('VILNIUS LITHUANIA X TECHNINE')
        end

        it 'should return the direct url' do
          expect(api.scrape[:direct_url]).to eq('https://player.vimeo.com/video/85321778')
        end

        it 'should return a thumbnail' do
          expect(api.scrape[:thumbnail]).to eq('http://b.vimeocdn.com/ts/462/580/462580949_640.jpg')
        end

        it 'should return the original post date' do
          expect(api.scrape[:post_date]).to eq(DateTime.new(2014, 01, 29, 02, 04, 29))
        end
      end

      context 'kaltura' do
        let(:api) { SnowboarderMag.new('./spec/assets/sbm_kaltura_rss.xml') }

        it 'should return the title' do
          expect(api.scrape[:title]).to eq('Vans Presents Introspect: Iouri Podladtchikov')
        end

        it 'should return the direct url' do
          expect(api.scrape[:post_url]).to eq('http://www.snowboardermag.com/videos/vans-presents-introspect-iouri-podladtchikov/')
        end

        it 'should return a thumbnail' do
          expect(api.scrape[:thumbnail]).to eq('http://cdn.snowboardermag.com/files/2014/01/Vans-Introspect-IPod-Jan14-fi.jpg')
        end

        it 'should return the original post date' do
          expect(api.scrape[:post_date]).to eq(DateTime.new(2014, 01, 31, 16, 00, 00))
        end      
      end
    end
  end
end
