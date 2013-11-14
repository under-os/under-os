class UnderOs::UI::Input < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UITextField, tag: 'input'

  def initialize(options={})
    super

    # self.type        = options[:type]        if options[:type]
    self.value       = options[:value]       if options[:value]
    self.placeholder = options[:placeholder] if options[:placeholder]
    self.keyboard    = options[:keyboard]    if options[:keyboard]

    @_.delegate      = self
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

  def textFieldShouldReturn(textField)
    hide_keyboard
    false
  end

  def hide_keyboard
    @_.resignFirstResponder
  end

end
