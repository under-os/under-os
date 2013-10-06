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
        @view.frame = [[left, top], [convert_size(width, :x), height]]
      end

      def height
        @view.frame.size.height
      end

      def height=(height)
        @view.frame = [[left, top], [width, convert_size(height, :y)]]
      end

      def top
        @view.frame.origin.y
      end

      def top=(top)
        @view.frame = [[left, convert_size(top, :y)], [width, height]]
      end

      def left
        @view.frame.origin.x
      end

      def left=(left)
        @view.frame = [[convert_size(left, :x), top], [width, height]]
      end

      def right
        parent_size.x - left
      end

      def right=(right)
        @view.frame = [[parent_size[:x] - convert_size(right, :x) - width, top], [width, height]]
      end

      def bottom
        parent_size.y - top
      end

      def bottom=(bottom)
        @view.frame = [[left, parent_size[:y] - convert_size(bottom, :y) - height], [width, height]]
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
        size = view.superview.frame.size
        {x: size.width, y: size.height}
      end
    end
  end
end
