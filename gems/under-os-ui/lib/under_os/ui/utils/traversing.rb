module UnderOs::UI::Traversing
  def first(css_rule)
    find(css_rule)[0]
  end

  def find(css_rule)
    [].tap do |result|
      children.each do |view|
        result << view if view.matches(css_rule)
        view.find(css_rule).each do |sub|
          result << sub
        end
      end
    end
  end

  def matches(css_rule)
    UnderOs::Page::StylesMatcher.new(css_rule).match(self)
  end

  def parent(css_rule=nil)
    if ! css_rule
      UnderOs::UI::View.new(@_.superview) if @_.superview
    else
      parent = self
      while parent.is_a?(UnderOs::UI::View) && (parent = parent.parent)
        return parent if parent.matches(css_rule)
      end
    end
  end

  def children(css_rule=nil)
    result = @_.subviews.map{|v| UnderOs::UI::View.new(v) if v}.compact
    css_rule ? result.select{|v| v.matches(css_rule)} : result
  end

  def siblings(css_rule=nil)
    parent ? (parent.children(css_rule) - [self]) : []
  end

  def empty?
    @_.subviews.empty?
  end
end
