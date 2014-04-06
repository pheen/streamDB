module Sites
  class YoutubeFeed

    def initialize(sport, *accounts)
      @accounts = accounts
      @sport    = sport
    end

    def scrape
      @accounts.map do |account|
        videos = api.videos_by(:user => account).videos.flatten
        videos.map do |video|
          {
            title: video.title,
            direct_url: video.embed_url,
            thumbnail: video.thumbnails.find {|thumb| thumb.name == "hqdefault" }.url,
            post_date: video.uploaded_at,
            post_url:  video.embed_url,
            sport: @sport
          }
        end
      end
    end

    def api
      @api ||= YouTubeIt::Client.new(:dev_key => "AI39si52u6DTvqlTHvHTE-v4v7Blp0h3O5TyVU2PuPWvD87yS4bKGcDjlPOgb5OHhY5XNFsugQvCV1XSpxTFL_zCNZB4-I9WRQ")
      @api ||= @api.client
    end

  end
end
