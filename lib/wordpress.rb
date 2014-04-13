module Wordpress
  def video_nodes(url)
    xml = Nokogiri::XML(open(url))
    nodes = xml.css('item')

    nodes.to_a.select do |node|
      cdata = node.element_children.css('category').map(&:children).flatten.map(&:text)
      cdata.include?('Videos')
    end
  end
end
