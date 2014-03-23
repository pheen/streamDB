require 'spec_helper'
require './lib/robot.rb'

describe Scrape::Robot do
  describe 'scraping' do
    context 'all sites' do
      #let(:sites) { [:tws, :sbm, :ytc, :vc] }
      let(:sites) { [:tws] }
      let(:robot) { Scrape::Robot.new(sites) }

      context 'successfully' do
        it 'should return video info' do
          #expect(robot.start_scraping).to eq('?')
        end

        it 'should save' do
          robot.start_scraping
          expect(robot.save).to eq(["success", "success", "success", "success", "success", "success"])
        end
      end
    end
  end
end
