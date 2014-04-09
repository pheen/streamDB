module Scrapper
  class VimeoScrapper
    def self.find_info(node)
      scrapper = VimeoScrapper.new(node)
      scrapper.find_info
    end

    def initialize(node)
      @node = node
    end

    def find_info
      return {} unless valid_node?

      {
        title: @api['title'],
        direct_url: "https://player.vimeo.com/video/#{@id}",
        thumbnail: @api["thumbnail_large"],
        post_date: @api['upload_date'].to_datetime
      }
    end

    def valid_node?
      @node &&
      set_id &&
      set_api
    end

    def set_id
      url = @node.attr('src') || @node.css('a').attr('href')
      pattern = /(vimeo\.come\/?(video)\/|(?<id>\d+))/
      match = url.to_s.match(pattern)

      if match && match[:id] =~ /\d{8}/
        @id = match[:id] and true
      else
        false
      end
    end

    def set_api
      api ||= Vimeo::Simple::Video.info("#{@id}")

      unless api =~ /not found/
        @api = api.first
        true
      else
        false
      end
    end
  end
end
