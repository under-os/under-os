module UnderOs::UI::Traversing
  class NodeList < Array

    def method_missing(*args, &block)
      each do |element|
        element.__send__(*args, &block).tap do |result|
          unless result === element
            return result # all modifiers return a reference to the element itself
          end
        end
      end
    end

  end

  def first(css_rule)
    find(css_rule)[0]
  end

  def find(css_rule)
    NodeList.new.tap do |list|
      children.each do |view|
        list << view if view.matches(css_rule)
        view.find(css_rule).each do |sub|
          list << sub
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
