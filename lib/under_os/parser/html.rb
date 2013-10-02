class UnderOs::Parser::HTML
  def parse(html)
    html = html.strip.gsub(/>\s+/, '>').gsub(/\s+</, '<')

    [].tap do |top|
      @top   = top
      @stack = []
      @node  = nil
      i      = 0

      while i < html.size
        @chunk = html.slice(i, html.size)

        i += open_tag || close_tag || plain_text
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
      if @node
        @stack.pop

        if m[1] == @node[:tag]
          @node = @stack.last
        elsif @stack.last
          if m[1] == @stack.last[:tag]
            if @node[:children]
              @stack.last[:children] += @node[:children]
              @node.delete(:children)
              @node.delete(:text)
            end
            @stack.pop
            @node = @stack.last
          else
            throw "ERROR: Unexpected close tag #{m[0]}"
          end
        else
          throw "ERROR: No open tag for #{m[0]}"
        end
      else
        throw "ERROR: No open tag for #{m[0]}"
      end

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
        hash[match[0].to_sym] = match[2]
      end
    end
  end
end
