class NavbarPage < UnderOs::Page
  def initialize
    find('#buttons button').each do |button|
      button.on :tap do
        if button.hasClass('icons')
          navbar.right_buttons = @icons = button.data('icons').split(',').map do |type|
            UnderOs::UI::Icon.new(type: type)
          end
        else
          navbar.right_buttons = {}.tap do |hash|
            button.data('icons').split(',').map do |type|
              hash[type] = Proc.new{ p type }
            end
          end
        end
      end
    end
  end
end
