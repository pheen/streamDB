module Sites
  class VimeoFeed

    def initialize(sport, *accounts)
      @accounts = accounts
      @sport    = sport
    end

    def scrape
      @accounts.map do |account|
        videos = api.videos(account).flatten
        videos.map do |video|
          {
            title: video['title'],
            direct_url: "https://player.vimeo.com/video/#{video['id']}",
            thumbnail: video['thumbnail_large'],
            post_date: DateTime.parse(video['upload_date']),
            post_url:  "https://player.vimeo.com/video/#{video['id']}",
            sport: @sport
          }
        end
      end
    end

    def api
      @api ||= Vimeo::Simple::User
    end

  end
end
