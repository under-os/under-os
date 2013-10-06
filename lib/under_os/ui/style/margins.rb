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
      end
    end
  end
end
