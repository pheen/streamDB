require 'sites'

class Robot
  include Sites

  SITES = {
    snow: [
      TransworldSnow,
      SnowboarderMag,
      VimeoFeed.new('snow', 'user1083256')
    ],
    skate: [
      TransworldSkate,
      YoutubeFeed.new('skate', 'ThrasherMagazine')
    ],
    surf: [
      TransworldSurf,
      YoutubeFeed.new('surf', 'surfer')
    ]
  }

  def self.scrape(*sports)
    sports = SITES.keys if sports.empty?
    sites = sports.map {|sport| SITES.fetch(sport) }.flatten
    results = sites.map(&:scrape).flatten

    results.map! do |video|
      result = Video.new(
        title:      video[:title],
        direct_url: video[:direct_url],
        post_url:   video[:post_url],
        thumbnail:  video[:thumbnail],
        post_date:  video[:post_date],
        sport:      video[:sport]
      )

      if result.save
        {
          :result =>     :success,
          :title =>      result.title,
          :direct_url => result.direct_url,
          :post_url =>   result.post_url,
          sport:         video[:sport]
        }
      else
        {
          :result => :fail,
          :errors => result.errors
        }
      end
    end

    puts results
  end
end
