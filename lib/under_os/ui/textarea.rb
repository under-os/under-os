class UnderOs::UI::Textarea < UnderOs::UI::Input
  wraps UITextView, tag: 'textarea'

  alias :text= :value= # to get values from the HTML layouts
end
