require 'youtube_it'

module Scrapper
  class YoutubeScrapper
    def self.find_info(node_set)
      scrapper = YoutubeScrapper.new(node_set)
      scrapper.find_info
    end    

    def initialize(node_set)
      @node_set = node_set
    end

    def find_info
      return {} unless valid_node_set?

      {
        title: @api.title,
        direct_url: @api.media_content[0].url,
        thumbnail: @api.thumbnails.find {|thumb| thumb.name == "hqdefault" }.url,
        post_date: @api.uploaded_at
      }
    end

    def valid_node_set?
      @node_set.one? &&
      set_id &&
      set_api
    rescue
      false
    end

    def set_id
      node = @node_set.first
      pattern = /\.com\/embed\/(?<id>[\d\w\-]*)/

      url = node.attr('src')
      @id = url.to_s.match(pattern)[:id]

      if @id =~ /[\d\w\-]{11}/
        true
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
