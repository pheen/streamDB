module Sites
  class TransworldSurf
    include Wordpress

    def initialize(url)
      @url = url
      @video_html = Nokogiri::HTML(open('http://surf.transworld.net/category/videos/'))
    end

    def self.scrape(url = 'http://surf.transworld.net/feed/')
      tws = TransworldSurf.new(url)
      tws.scrape
    end

    def scrape
      video_nodes(@url).map do |xml|
        node_details(xml).merge(
          post_url:  xml.css('link').text,
          sport: 'surf'
        )
      end
    end

    def node_details(xml)
      node_set = find_node(xml)
      node_info = Scrapper.find_info(node_set)

      if node_info.one?
        node_info.first
      else
        generic_info(xml)
      end
    end

    def find_node(xml)
      url  = xml.css('link').text
      html = Nokogiri::HTML(open(url))
      selectors = [
        # vimeo
        'iframe[src*="player.vimeo.com/video/"]',
        # youtube
        '.vvqyoutube',
        'iframe[src*="youtube.com/embed/"]'
      ]

      node = selectors.map do |selector|
        html.css(selector)
      end.flatten.first

      node
    end

    def generic_info(xml)
      {
        title:     xml.css('title').text,
        thumbnail: thumbnail(xml.css('link').text),
        post_date: xml.css('pubDate').text.to_datetime
      }
    end

    def thumbnail(post_url)
      img_url = @video_html.css("a[href='#{post_url}'] > img").attr('src').value
      img_url.sub('-145x82', '')
    end
  end
end
