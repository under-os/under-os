#
# This module handles all sorts of things related to fonts
# and text attributes
#
module UnderOs::UI
  class Style
    module Fonts
      def fontFamily
        @view.font.familyName
      end

      def fontFamily=(value)
        @view.font = UIFont.fontWithName(value, size: @view.font.pointSize)
      end

      def fontSize
        @view.font.pointSize
      end

      def fontSize=(value)
        @view.font  = @view.font.fontWithSize(value)
        @view.sizeToFit if @type == :icon
      end

      def textAlign
        if @view.is_a?(UIButton)
          BUTTONS_ALIGMENTS_MAP.key(@view.contentHorizontalAlignment)
        elsif @view.respond_to?(:textAlignment)
          TEXTNODES_ALIGMENTS_MAP.key(@view.textAlignment)
        end
      end

      def textAlign=(value)
        if @view.is_a?(UIButton)
          @view.contentHorizontalAlignment = BUTTONS_ALIGMENTS_MAP[value.to_s] || BUTTONS_ALIGMENTS_MAP['left']
        elsif @view.respond_to?(:textAlignment)
          @view.textAlignment = TEXTNODES_ALIGMENTS_MAP[value.to_s] || BUTTONS_ALIGMENTS_MAP['left']
        end
      end

      BUTTONS_ALIGMENTS_MAP = {
        'right'   => UIControlContentHorizontalAlignmentRight,
        'center'  => UIControlContentHorizontalAlignmentCenter,
        'justify' => UIControlContentHorizontalAlignmentFill,
        'left'    => UIControlContentHorizontalAlignmentLeft
      }

      TEXTNODES_ALIGMENTS_MAP = {
        'right'   => NSTextAlignmentRight,
        'center'  => NSTextAlignmentCenter,
        'justify' => NSTextAlignmentJustified,
        'left'    => NSTextAlignmentLeft
      }
    end
  end
end
