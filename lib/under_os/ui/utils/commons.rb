module UnderOs::UI::Commons
  def id
    @_id
  end

  def id=(id)
    @_id = id
  end

  def tagName
    @_tag_name ||= begin
      wraps = UnderOs::UI::Wrap::WRAPS_TAGS_MAP
      klass = self.class; tag = 'VIEW'

      while klass
        if wrap = wraps.detect{|t,k| k == klass}
          tag = wrap[0].upcase
          break
        else
          klass = klass.superclass
        end
      end

      tag
    end
  end

  def data
    @_data
  end

  def data=(hash)
    @_data = hash
  end

  def page
    resp = @_

    while resp = resp.nextResponder
      if resp.is_a?(UIViewController)
        return resp.wrapper
      end
    end

    nil
  end

  def hide
    style.display = :none
  end

  def show
    style.display = :block
  end

  def toggle
    hidden ? show : hide
  end

  def hidden
    @_.isHidden
  end

  def visible
    !hidden
  end

  alias :hidden?  :hidden
  alias :visible? :visible
end
