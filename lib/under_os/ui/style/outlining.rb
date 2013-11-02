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

      def backgroundImage
        @background_image
      end

      def backgroundImage=(image)
        @background_image = UnderOs::UI::Image.new(src: image, class: 'uos-background-image') if image.is_a?(String)
        @background_image._.frame = [[0, 0], [@view.frame.size.width, @view.frame.size.height]]
        @view.insertSubview(@background_image._, atIndex: 0)
      end

      alias :background  :backgroundColor
      alias :background= :backgroundColor=

      def color(state=UIControlStateNormal)
        if @view.is_a?(UIButton)
          @view.titleColorForState(state)
        elsif @view.respond_to?(:textColor)
          @view.textColor
        elsif @view.respond_to?(:color)
          @view.color
        end
      end

      def color=(color, state=UIControlStateNormal)
        if @view.is_a?(UIButton)
          @view.setTitleColor convert_color(color), forState:state
        elsif @view.respond_to?(:textColor)
          @view.textColor = convert_color(color)
        elsif @view.respond_to?(:color)
          @view.color = convert_color(color)
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
