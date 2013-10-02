class UnderOs::UI::Textarea < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UITextView, tag: 'textarea'

  def initialize(options={})
    super

    self.value       = options[:value]       if options[:value]
    self.keyboard    = options[:keyboard]    if options[:keyboard]
  end
end
