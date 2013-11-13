#
# This module handles all sorts of things related to fonts
# and text attributes
#
module UnderOs::UI
  class Style
    module Fonts
      def fontFamily
      end

      def fontFamily=(value)
        @view.font = @view.font.fontWithName(value)
      end

      def fontSize
      end

      def fontSize=(value)
        @view.font  = @view.font.fontWithSize(value)
        @view.sizeToFit if @type == :icon
      end

      def textAlign
        if @view.is_a?(UIButton)
          case @view.contentHorizontalAlignment
            when UIControlContentHorizontalAlignmentRight  then 'right'
            when UIControlContentHorizontalAlignmentCenter then 'center'
            when UIControlContentHorizontalAlignmentFill   then 'justify'
            else                                                'left'
          end
        elsif @view.respond_to?(:textAlignment)
          case @view.textAlignment
            when NSTextAlignmentRight     then 'right'
            when NSTextAlignmentCenter    then 'center'
            when NSTextAlignmentJustified then 'justify'
            else                               'left'
          end
        end
      end

      def textAlign=(value)
        if @view.is_a?(UIButton)
          @view.contentHorizontalAlignment = case value.to_s
            when 'right'   then UIControlContentHorizontalAlignmentRight
            when 'center'  then UIControlContentHorizontalAlignmentCenter
            when 'justify' then UIControlContentHorizontalAlignmentFill
            else                UIControlContentHorizontalAlignmentLeft
          end
        elsif @view.respond_to?(:textAlignment)
          @view.textAlignment = case value.to_s
            when 'right'   then NSTextAlignmentRight
            when 'center'  then NSTextAlignmentCenter
            when 'justify' then NSTextAlignmentJustified
            else                NSTextAlignmentLeft
          end
        end
      end
    end
  end
end
