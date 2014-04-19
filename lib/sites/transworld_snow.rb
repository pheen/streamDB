module Sites
  class TransworldSnow
    include Wordpress

    def initialize(url)
      @url = url
    end

    def self.scrape(url = 'http://snowboarding.transworld.net/feed/')
      tws = TransworldSnow.new(url)
      tws.scrape
    end

    def scrape
      video_nodes(@url).map do |xml|
        node_details(xml).merge(
          post_url:  xml.css('link').text,
          sport: 'snow'
        )
      end
    end

    def node_details(xml)
      node_set = find_nodes(xml)
      node_info = Scrapper.find_info(node_set)

      if node_info.one?
        node_info.first
      else
        generic_info(xml)
      end
    end

    def find_nodes(xml)
      url  = xml.css('link').text
      html = Nokogiri::HTML(open(url))
      selectors = {
        vimeo: '.vvqvimeo, iframe[src*="player.vimeo.com/video/"]',
        youtube: '.vvqyoutube, iframe[src*="youtube.com/embed/"]'
      }

      selectors.values.map do |selector|
        html.css(selector)
      end.flatten.first
    end

    def generic_info(xml)
      {
        title:     xml.css('title').text,
        thumbnail: thumbnail(xml.css('link').text),
        post_date: xml.css('pubDate').text.to_datetime
      }
    end

    def thumbnail(post_url)
      post_html = Nokogiri::HTML(open(post_url))
      thumb     = post_html.css('img[class*="wp-image"]').attr('src').value

      ## FAKE
      thumb || 'http://www.waterville.com/userfiles/image/images/logo-transworld.gif'
    end
  end
end
