require 'vimeo'

module Scrapper
  class VimeoScrapper
    def self.find_info(node_set)
      scrapper = VimeoScrapper.new(node_set)
      scrapper.find_info
    end

    def initialize(node_set)
      @node_set = node_set
    end

    def find_info
      return {} unless valid_node_set?

      {
        title: @api['title'],
        direct_url: "https://player.vimeo.com/video/#{@id}",
        thumbnail: @api["thumbnail_large"],
        post_date: @api['upload_date'].to_datetime
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
      url = node.attr('src')
      pattern = /(vimeo\.come\/?(video)\/|(?<id>\d+))/

      @id = url.to_s.match(pattern)[:id]

      if @id =~ /\d{8}/
        true
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
