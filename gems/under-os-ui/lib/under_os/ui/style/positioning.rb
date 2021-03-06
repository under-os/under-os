#
# This module contains things like positions and sizes of the elements
#
module UnderOs::UI
  class Style
    module Positioning
      def width
        @view.frame.size.width
      end

      def width=(width)
        @view.frame = @view.frame.tap do |frame|
          frame.size.width = convert_size(width, :x)
        end
      end

      def height
        @view.frame.size.height
      end

      def height=(height)
        @view.frame = @view.frame.tap do |frame|
          frame.size.height = convert_size(height, :y)
        end
      end

      def top
        @view.frame.origin.y
      end

      def top=(top)
        @view.frame = @view.frame.tap do |frame|
          frame.origin.y = convert_size(top, :y)
        end
      end

      def left
        @view.frame.origin.x
      end

      def left=(left)
        @view.frame = @view.frame.tap do |frame|
          frame.origin.x = convert_size(left, :x)
        end
      end

      def right
        parent_size.x - left
      end

      def right=(right)
        @view.frame = @view.frame.tap do |frame|
          frame.origin.x = parent_size[:x] - convert_size(right, :x) - frame.size.width
        end
      end

      def bottom
        parent_size.y - top
      end

      def bottom=(bottom)
        @view.frame = @view.frame.tap do |frame|
          frame.origin.y = parent_size[:y] - convert_size(bottom, :y) - frame.size.height
        end
      end

      def contentWidth
        @view.contentSize.width rescue 0
      end

      def contentWidth=(value)
        return unless @view.is_a?(UIScrollView)

        if value == 'auto'
          value = 0
          @view.subviews.each do |view|
            x = view.origin.x + view.size.width
            value = x if x > value
          end
        end

        @view.contentSize = CGSizeMake(value, contentHeight)
      end

      def contentHeight
        @view.contentSize.height rescue 0
      end

      def contentHeight=(value)
        return unless @view.is_a?(UIScrollView)

        if value == 'auto'
          value = 0
          @view.subviews.each do |view|
            y = view.origin.y + view.size.height
            value = y if y > value
          end
        end

        @view.contentSize = CGSizeMake(contentWidth, value)
      end

      def zIndex
        @view.layer.zPosition
      end

      def zIndex=(number)
        @view.layer.zPosition = number
      end

      def overflow
        case "#{overflowX}-#{overflowY}"
        when 'visible-visible' then :visible
        when 'hidden-hidden'   then :hidden
        when 'scroll-scroll'   then :scroll
        when 'scroll-visible'  then :x
        when 'visible-scroll'  then :y
        else                   [overflowX, overflowY]
        end
      end

      def overflow=(value)
        x, y = case value.to_s
        when 'x'       then ['scroll',  'visible']
        when 'y'       then ['visible', 'scroll']
        when 'hidden'  then ['hidden',  'hidden']
        when 'visible' then ['visible', 'visible']
        else                ['scroll',  'scroll']
        end

        self.overflowX = x
        self.overflowY = y
      end

      def overflowX
        @view.isScrollEnabled ? @view.showsHorizontalScrollIndicator ? :scroll : :hidden : :visible
      end

      def overflowX=(value)
        return unless @view.is_a?(UIScrollView)
        @view.directionalLockEnabled = overflowY == :visible
        @view.showsHorizontalScrollIndicator = value.to_s == 'scroll'
        @view.scrollEnabled = value.to_s != 'visible' || overflowY != :visible
      end

      def overflowY
        @view.isScrollEnabled ? @view.showsVerticalScrollIndicator ? :scroll : :hidden : :visible
      end

      def overflowY=(value)
        return unless @view.is_a?(UIScrollView)
        @view.directionalLockEnabled = overflowX == :visible
        @view.showsVerticalScrollIndicator = value.to_s == 'scroll'
        @view.scrollEnabled = overflowX != :visible || value.to_s != 'visible'
      end

    private

      def convert_size(size, dim)
        if size.is_a?(String)
          if size.ends_with?('%')
            size = size.slice(0, size.size-1).to_f
            size = parent_size[dim] / 100.0 * size
          end
        end

        size
      end

      def parent_size
        parent = view.superview

        if !parent.superview && parent == UnderOs::App.history.current_page.view._
          parent = UIScreen.mainScreen.bounds.size
        else
          parent = parent.frame.size
        end

        {x: parent.width, y: parent.height}
      end
    end
  end
end
