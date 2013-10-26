class AlertsPage < UnderOs::Page
  def initialize
    find('#buttons button').each_with_index do |button, index|
      button.on :tap do
        case index
        when 1 then Alert.new(title: "Error", message: button.text)
        when 2 then Alert.new(message: button.text, button: "Doh...")
        when 3 then Alert.new(message: button.text, buttons: ["Option 1", "Option 2"])
        else        Alert.new(button.text)
        end
      end
    end
  end
end
