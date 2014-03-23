module Sites
  class SnowboarderMag
    include Wordpress

    def initialize(url)
      @url = url
    end

    def self.scrape(url  = 'http://www.snowboardermag.com/feed/')
      sbm = SnowboarderMag.new(url)
      sbm.scrape
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
        vimeo: 'iframe[src*="player.vimeo.com/video/"]',
        youtube: '.vvqyoutube, iframe[src*="youtube.com/embed/"]' # odd..
      }

      selectors.values.map do |selector|
        html.css(selector)
      end.flatten
    end

    def generic_info(xml)
      {
        title:     xml.css('title').text,
        thumbnail: thumbnail(xml.css('link').text),
        post_date: xml.css('pubDate').text.to_datetime
      }
    end

    def thumbnail(post_url)
      video_list_html = Nokogiri::HTML(open('http://www.snowboardermag.com/videos/'))
      href_pattern    = post_url[/\/videos\/.*\//]
      thumbnail       = video_list_html.css("a[href='#{href_pattern}'] img:not([src*='shim'])")

      if thumbnail.blank?
        'http://cdn.snowboardermag.com/files/2011/01/snowboarder-logo-web.jpg'
      else
        thumbnail.attr('src').value
      end
    end
  end


  class YoutubeCollection
    def scrape
    end
  end

  class VimeoCollection
    def scrape
    end
  end
end
