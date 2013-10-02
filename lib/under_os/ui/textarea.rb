class UnderOs::UI::Textarea < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UITextView, tag: 'textarea'

  def initialize(options={})
    options.merge!({
      style: {
        borderWidth: 1,
        borderColor: :lightGray,
        borderRadius: 2
      }
    })

    super

    self.value       = options[:value]       if options[:value]
    self.keyboard    = options[:keyboard]    if options[:keyboard]
  end

  alias :text= :value= # to get values from the HTML layouts
end
