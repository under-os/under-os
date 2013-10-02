class UnderOs::UI::Input < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UITextField, tag: 'input'

  def initialize(options={})
    options.merge!({
      style: {
        borderWidth: 1,
        borderColor: :lightGray,
        borderRadius: 2
      }
    })

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

end
