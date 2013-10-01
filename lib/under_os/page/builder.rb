class UnderOs::Page::Builder

  def self.views_from(source)
    @inst ||= new
    if source.is_a?(String)
      @inst.from_html(source)
    else
      @inst.from_nodes(source)
    end
  end

  def from_html(source)
    @html ||= UnderOs::Parser::HTML.new
    from_nodes @html.parse(source)
  end

  def from_nodes(list)
    list.map do |node|
      build_view_from(node)
    end
  end

  def build_view_from(node)
    klass   = class_for_tag(node[:tag])
    options = options_from_attrs(node[:attrs] || {})

    if klass.instance_methods.include?(:text) && node[:text]
      options[:text] = node[:text]
    end

    klass.new(options).tap do |view|
      if node[:children] && node[:children].any?
        from_nodes(node[:children]).each do |child|
          view.insert child
        end
      end
    end
  end

  def class_for_tag(tag)
    UnderOs::UI.const_get({
      img:    'Image',
      icon:   'Icon',
      label:  'Label',
      button: 'Button'
    }[tag.to_sym] || 'View')
  end

  def options_from_attrs(hash)
    {}.tap do |options|
      hash.each do |key, value|
        options[key] = value
      end
    end
  end
end
