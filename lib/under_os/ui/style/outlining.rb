#
# This module contains things like colors, borders, shadows, etc
#
module UnderOs::UI
  class Style
    module Outlining
      def opacity
        @view.alpha
      end

      def opacity=(value)
        @view.alpha = value
      end

      def backgroundColor
        @view.backgroundColor
      end

      def backgroundColor=(color, state=UIControlStateNormal)
        if @view.is_a?(UIButton)
          @view.setBackgroundColor convert_color(color), forState:state
        else
          @view.backgroundColor = convert_color(color)
        end
      end

      alias :background  :backgroundColor
      alias :background= :backgroundColor=

      def color(state=UIControlStateNormal)
        if @view.is_a?(UIButton)
          @view.titleColorForState(state)
        else
          @view.textColor if @view.respond_to?(:textColor)
        end
      end

      def color=(color, state=UIControlStateNormal)
        if @view.is_a?(UIButton)
          @view.setTitleColor convert_color(color), forState:state
        else
          @view.textColor = convert_color(color) if @view.respond_to?(:textColor)
        end
      end

      def borderRadius
        @view.layer.cornerRadius
      end

      def borderRadius=(radius)
        @view.clipsToBounds      = true
        @view.layer.cornerRadius = radius
      end

      def borderColor
        @view.layer.borderColor
      end

      def borderColor=(color)
        @view.layer.borderColor = convert_color(color).CGColor
      end

      def borderWidth
        @view.layer.borderWidth
      end

      def borderWidth=(width)
        @view.layer.borderWidth = width
      end

    private

      def convert_color(color)
        UnderOs::Color.new(color).ui
      end
    end
  end
end
