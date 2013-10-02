class UnderOs::Parser::HTML
  def parse(html)
    html = html.strip.gsub(/<\!--[\s\S]*?-->/, '').gsub(/>\s+/, '>').gsub(/\s+</, '<')

    [].tap do |top|
      @top   = top
      @stack = []
      @node  = nil
      i      = 0

      while i < html.size
        @chunk = html.slice(i, html.size)

        i += open_tag || close_tag || plain_text
      end

      # closing all the missing tags
      while node = @stack.shift
        node.delete(:children)
        node.delete(:text)
        @top << node if ! @top.include?(node)
      end
    end
  end

  def open_tag
    if m = @chunk.match(/\A<([a-z]+)([^>]*)>/)
      @node = {tag: m[1], attrs: parse_attrs_in(m[2])}

      if parent = @stack.last
        parent[:children] ||= []
        parent[:children] << @node
        parent.delete(:text) # it can have either text or children
      else
        @top << @node
      end

      @stack << @node

      m[0].size
    end
  end

  def close_tag
    if m = @chunk.match(/\A<\/([a-z]+)>/)
      while node = @stack.pop
        if node[:tag] != m[1]
          if @stack.size > 0
            @stack.last[:children] += node[:children] || []
            node.delete(:children)
            node.delete(:text)
          end
        else
          break
        end
      end

      @node = @stack.last

      m[0].size
    end
  end

  def plain_text
    if m = @chunk.match(/\A([^<]+)/)
      @stack.last[:text] = m[1] if @stack.last

      m[0].size
    end
  end

  def parse_attrs_in(string)
    {}.tap do |hash|
      string.scan(/([a-z][a-z_\-\d]+)=('|")(.+?)(\2)/).each do |match|
        value = match[0] == match[2] ? true : match[2]
        value = true  if value == 'true'
        value = false if value == 'false'
        hash[match[0].to_sym] = value
      end
    end
  end
end
