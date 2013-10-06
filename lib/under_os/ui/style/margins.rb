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
        value = to_4dim_array(value)
        self.marginTop    = value[0]
        self.marginLeft   = value[3]
        self.marginRight  = value[1]
        self.marginBottom = value[2]
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

    private

      def to_4dim_array(value)
        if value.is_a?(String)
          value = value.gsub('px', '').strip.split().reject(&:blank?).map(&:to_f)
        end

        value = Array(value)
        case value.size
        when 1 then value * 4
        when 2 then [value[0], value[1], value[0], value[1]]
        else        value
        end
      end

      def set_offsets
        return nil if display != :inline

        position_x    = marginLeft
        position_y    = marginTop

        parent_view   = view.superview
        previous_view = parent_view.subviews[parent_view.subviews.index(view)-1] unless parent_view.subviews[0] === view

        if previous_view
          pos  = previous_view.frame.origin
          size = previous_view.frame.size

          position_x += pos.x + size.width

          if wrap = UnderOs::UI::View.wrap_for(view)
            position_x += wrap.style.marginRight
          end
        end

        view.frame = [[position_x, position_y],[
          view.frame.size.width, view.frame.size.height
        ]]
      end
    end
  end
end
