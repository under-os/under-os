class UnderOs::UI::Input < UnderOs::UI::View
  wraps UITextField, tag: 'input'

  def initialize(options={})
    super

    self.type        = options[:type]        if options[:type]
    self.name        = options[:name]        if options[:name]
    self.value       = options[:value]       if options[:value]
    self.placeholder = options[:placeholder] if options[:placeholder]
    self.keyboard    = options[:keyboard]    if options[:keyboard]
    self.disabled    = true                  if options[:disabled]

    @_.delegate      = self if @_.respond_to?(:delegate=)
  end

  def name
    @name
  end

  def name=(text)
    @name = text
  end

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

  def type
    if @_.respond_to?(:secureTextEntry) && @_.secureTextEntry
      :password
    else
      keyboard == :default ? :text : keyboard
    end
  end

  def type=(type)
    case type.to_sym
    when :password then @_.secureTextEntry = true
    else self.keyboard = type
    end
  end

  def keyboard
    KEYBOARDS.index(@_.keyboardType)
  end

  def keyboard=(keyboard)
    keyboard = keyboard.to_sym if keyboard.is_a?(String)
    keyboard = KEYBOARDS[keyboard] || keyboard

    raise "Unknown keyboard type: #{keyboard}" if keyboard.is_a?(Symbol)

    @_.keyboardType = keyboard
  end

  def hide_keyboard
    puts "DEPRECATED: please use the `#blur` method instead of `#hide_keyboard`"
    blur
  end

  KEYBOARDS = {
    default:   UIKeyboardTypeDefault,
    text:      UIKeyboardTypeDefault,
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

  def disabled
    ! @_.isEnabled
  end

  alias :disabled? :disabled

  def disabled=(value)
    @_.enabled = ! value
  end

  def disable
    self.disabled = true
  end

  def enable
    self.disabled = false
  end

  def focus
    @_.becomeFirstResponder
  end

  def blur
    @_.resignFirstResponder
  end

# delegate

  def textFieldShouldReturn(textField)
    blur
    false
  end

end
