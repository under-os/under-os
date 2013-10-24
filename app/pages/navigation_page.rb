class NavigationPage < UnderOs::Page
  def initialize
    find('#buttons button').each do |button|
      button.on :tap do
        self.navigation.right_buttons = button.data('icons').split(',').map do |type|
          UnderOs::UI::Icon.new(type: type, style: {color: 'blue'})
        end
      end
    end
  end
end
