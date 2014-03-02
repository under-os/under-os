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
    klass   = class_for(node)
    options = options_from_attrs(node[:attrs] || {})

    if klass.instance_methods.include?(:text) && node[:text]
      options[:text] = node[:text]
    end

    klass.new(options).tap do |view|
      if node[:children] && node[:children].any?
        build_children_for(view, node[:children])
      end
    end
  end

  def class_for(node)
    if node[:attrs] && node[:attrs][:wrapper].is_a?(String)
      node[:attrs].delete(:wrapper).constantize
    else
      UnderOs::UI::Wrap::WRAPS_TAGS_MAP[node[:tag]] || UnderOs::UI::View
    end
  end

  def options_from_attrs(hash)
    {}.tap do |options|
      hash.each do |key, value|
        options[key] = value
      end
    end
  end

  def build_children_for(view, nodes)
    if view.is_a?(UnderOs::UI::Select)
      view.optgroups = select_optgroups_from(nodes)
    elsif view.is_a?(UnderOs::UI::Collection)
      find_collection_items_for(view, nodes)
    else
      from_nodes(nodes).each do |child|
        view.insert child
      end
    end
  end

  def select_optgroups_from(nodes)
    nodes = [{tag: 'optgroup', children: nodes}] if nodes[0][:tag] == 'option'

    nodes.map do |group|
      {}.tap do |options|
        group[:children].each do |option|
          if option[:tag] == 'option'
            label = option[:text]
            value = option[:attrs][:value] || label

            options[value] = label if value && label
          end
        end
      end
    end
  end

  def find_collection_items_for(collection, nodes)
    nodes.each do |node|
      klass = class_for(node)

      if klass <= UnderOs::UI::Collection::Item
        klass.build(collection) { from_nodes(node[:children]) }
      end

      # header
      # footer
    end
  end

end
