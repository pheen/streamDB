require 'youtube_it'

module Scrapper
  class YoutubeScrapper
    def self.find_info(node)
      scrapper = YoutubeScrapper.new(node)
      scrapper.find_info
    end    

    def initialize(node)
      @node = node
    end

    def find_info
      return {} unless valid_node?

      {
        title: @api.title,
        direct_url: @api.media_content[0].url,
        thumbnail: @api.thumbnails.find {|thumb| thumb.name == "hqdefault" }.url,
        post_date: @api.uploaded_at
      }
    end

    def valid_node?
      @node &&
      set_id &&
      set_api
    end

    def set_id
      url = @node.attr('src') || @node.css('a').attr('href')
      pattern = /\.com\/(embed|watch)\/?(\?v=)?(?<id>[\d\w\-]*)/
      match = url.to_s.match(pattern)

      if match && match[:id] =~ /[\d\w\-]{11}/
        @id = match[:id] and true
      else
        false
      end
    end

    def set_api
      @api = YoutubeAuth.client.video_by("#{@id}")
    rescue
      false
    end
  end

  class YoutubeAuth < YoutubeScrapper
      def self.client
        @client ||= YouTubeIt::Client.new(:dev_key => "AI39si52u6DTvqlTHvHTE-v4v7Blp0h3O5TyVU2PuPWvD87yS4bKGcDjlPOgb5OHhY5XNFsugQvCV1XSpxTFL_zCNZB4-I9WRQ")
      end
  end
end
