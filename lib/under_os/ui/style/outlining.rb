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
        image = UIImage.UIImage.imageNamed(image) if image.is_a?(String)

        if @view.is_a?(UIButton)
          @view.setBackgroundImage(image, forState:UIControlStateNormal)
        else
          @background_image = UnderOs::UI::Image.new(src: image, class: 'uos-background-image')
          @background_image._.frame = [[0, 0], [@view.frame.size.width, @view.frame.size.height]]
          @view.insertSubview(@background_image._, atIndex: 0)
        end
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

      def boxShadow
        [
          @view.layer.shadowOffset.width,
          @view.layer.shadowOffset.height,
          @view.layer.shadowRadius,
          @view.layer.shadowOpacity,
          UnderOs::Color.new(@view.layer.shadowColor).to_hex
        ].compact.join(" ")
      end

      def boxShadow=(value)
        x, y, radius, opacity, color = parse_shadow_params(value)

        @view.layer.shadowOffset  = CGSizeMake(x, y) if x && y
        @view.layer.shadowColor   = color.CGColor    if color
        @view.layer.shadowRadius  = radius           if radius
        @view.layer.shadowOpacity = opacity          if opacity
        @view.layer.shadowPath    = UIBezierPath.bezierPathWithRect(@view.layer.bounds).CGPath
      end

    private

      def convert_color(color)
        UnderOs::Color.new(color).ui
      end

      def parse_shadow_params(string)
        x, y, radius, opacity, color = string.strip.split

        x = x.sub /px$/, '' if x
        y = y.sub /px$/, '' if y
        radius  = radius.sub  /px$/, '' if radius
        opacity = opacity.sub /px$/, '' if opacity

        if ! color
          if opacity
            unless opacity =~ /^[\d\.]+$/
              color   = opacity
              opacity = nil
            end
          elsif radius
            unless radius =~ /^[\d\.]+$/
              color  = radius
              radius = nil
            end
          end
        end

        x = x.to_f if x
        y = y.to_f if y

        radius  = radius.to_f  if radius
        opacity = opacity.to_f if opacity
        color   = convert_color(color) if color

        [x, y, radius, opacity, color]
      end
    end
  end
end
