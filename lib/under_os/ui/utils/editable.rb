#
# A little trait to handle the common editable fields API
#
module UnderOs::UI::Editable
  KEYBOARDS = {
    default:   UIKeyboardTypeDefault,
    ascii:     UIKeyboardTypeASCIICapable,
    numeric:   UIKeyboardTypeNumbersAndPunctuation,
    url:       UIKeyboardTypeURL,
    numbers:   UIKeyboardTypeNumberPad,
    phone:     UIKeyboardTypePhonePad,
    name:      UIKeyboardTypeNamePhonePad,
    email:     UIKeyboardTypeEmailAddress,
    decimal:   UIKeyboardTypeDecimalPad,
    twitter:   UIKeyboardTypeTwitter,
    search:    UIKeyboardTypeWebSearch
  }

  def value
    @_.text
  end

  def value=(value)
    @_.text = value
  end

  def placeholder
    @_.placeholder
  end

  def placeholder=(value)
    @_.placeholder = value
  end

  def keyboard
    KEYBOARDS.detect{|n,v| v == @_.keyboardType }[0]
  end

  def keyboard=(keyboard)
    keyboard = keyboard.to_sym if keyboard.is_a?(String)
    @_.keyboardType = KEYBOARDS[keyboard] || keyboard
  end
end
