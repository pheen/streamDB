require 'sites'

class Robot
  include Sites

  SITES = [
    TransworldSnow,
    SnowboarderMag
  ]

  def self.scrape(*sites)
    sites = SITES if sites.empty?
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
