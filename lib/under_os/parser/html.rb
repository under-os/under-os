class UnderOs::Parser::HTML
  def parse(html)
    parse_nodes_in(html)
  end

  OPEN_TAG_RE = /<([a-z]+)([^>]*)>/

  def parse_nodes_in(html)
    [].tap do |nodes|
      while l_index = html.index(OPEN_TAG_RE)
        r_index    = html.index('>', l_index)
        tag_str    = html.slice(l_index, r_index - l_index + 1)
        tag, attrs = tag_str.match(OPEN_TAG_RE).to_a.slice(1, 2)
        close_tag  = "</#{tag}>"

        node       = {tag: tag, attrs: parse_attrs_in(attrs)}

        if close_index = html.index(close_tag)
          content      = html.slice(r_index + 1, close_index - r_index - 1)
          if content.index(OPEN_TAG_RE)
            node[:children] = parse_nodes_in(content)
          else
            node[:text] = content.strip
          end
        else
          close_index = r_index + 1
        end

        html = html.slice(close_index, html.size)

        nodes << node
      end
    end
  end

  def parse_attrs_in(string)
    {}.tap do |hash|
      string.scan(/([a-z][a-z_\-\d]+)=('|")(.+?)(\2)/).each do |match|
        hash[match[0].to_sym] = match[2]
      end
    end
  end
end
