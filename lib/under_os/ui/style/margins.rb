#
# This module handles styles related to margins and paddings
#
module UnderOs::UI
  class Style
    module Margins
      def display
        @display || :block
      end

      def display=(value)
        @display = %w[none block inline].include?(value.to_s) ? value.to_sym : :block
        @view.hidden = @display == :none
        set_offsets if @display == :inline
      end

      def margin
        [marginTop, marginRight, marginBottom, marginLeft]
      end

      def margin=(value)
        set_property(:margin, value)
      end

      def marginTop
        @margin_top || 0
      end

      def marginTop=(value)
        @margin_top = value
        set_offsets
      end

      def marginLeft
        @margin_left || 0
      end

      def marginLeft=(value)
        @margin_left = value
        set_offsets
      end

      def marginRight
        @margin_right || 0
      end

      def marginRight=(value)
        @margin_right = value
        set_offsets
      end

      def marginBottom
        @margin_botom || 0
      end

      def marginBottom=(value)
        @margin_botom = value
        set_offsets
      end

      def padding
        [paddingTop, paddingRight, paddingBottom, paddingLeft]
      end

      def padding=(value)
        set_property(:padding, value)
      end

      def paddingTop
        @padding_top || 0
      end

      def paddingTop=(value)
        @padding_top = value
        set_paddings
      end

      def paddingLeft
        @padding_left || 0
      end

      def paddingLeft=(value)
        @padding_left = value
        set_paddings
      end

      def paddingRight
        @padding_right || 0
      end

      def paddingRight=(value)
        @padding_right = value
        set_paddings
      end

      def paddingBottom
        @padding_botom || 0
      end

      def paddingBottom=(value)
        @padding_botom = value
        set_paddings
      end

    private

      def set_property(property, value)
        value = to_4dim_array(value)

        __send__ "#{property}Top=",    value[0]
        __send__ "#{property}Left=",   value[3]
        __send__ "#{property}Right=",  value[1]
        __send__ "#{property}Bottom=", value[2]
      end

      def to_4dim_array(value)
        value = value.gsub('px', '').split.map(&:to_f) if value.is_a?(String)
        value = Array(value)
        case value.size
        when 1 then value * 4
        when 2 then [value[0], value[1], value[0], value[1]]
        else        value
        end
      end

      def set_offsets
        return nil if display != :inline

        position_x = marginLeft + parent_offset_x
        position_y = marginTop

        view.frame = [[position_x, position_y], [
          view.frame.size.width, view.frame.size.height
        ]]
      end

      def set_paddings
        if @view.respond_to?(:contentEdgeInsets)
          @view.contentEdgeInsets = UIEdgeInsetsMake(paddingTop, paddingLeft, paddingBottom, paddingRight)
        end
      end

      def parent_offset_x
        offset        = 0
        parent_view   = view.superview

        unless parent_view.subviews[0] === view
          if previous_view = parent_view.subviews[parent_view.subviews.index(view)-1]
            pos  = previous_view.frame.origin
            size = previous_view.frame.size

            offset += pos.x + size.width

            if wrap = UnderOs::UI::View.wrap_for(view)
              offset += wrap.style.marginRight
            end
          end
        end

        offset
      end
    end
  end
end
