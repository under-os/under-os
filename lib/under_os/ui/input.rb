class UnderOs::UI::Input < UnderOs::UI::View
  wraps UITextField, tag: 'input'

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

  def initialize(options)
    super

    # self.type        = options[:type]        if options[:type]
    self.value       = options[:value]       if options[:value]
    self.placeholder = options[:placeholder] if options[:placeholder]
    self.keyboard    = options[:keyboard]    if options[:keyboard]
  end

  # FIXME apparently there is a problem with this property in rubymotion
  # def type
  #   if @_.secureTextEntry
  #     :password
  #   else
  #     :text
  #   end
  # end

  # def type=(type)
  #   case type.to_sym
  #   when :password then @_.secureTextEntry = true
  #   end
  # end

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
