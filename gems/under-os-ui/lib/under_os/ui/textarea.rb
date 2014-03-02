class UnderOs::UI::Textarea < UnderOs::UI::Input
  wraps UITextView, tag: 'textarea'

  alias :text= :value= # to get values from the HTML layouts

# delegate

  def textViewDidBeginEditing(textView)
    handle_focus
  end

  def textViewDidChange(textView)
    handle_change
  end

  def textViewDidEndEditing(textView)
    handle_blur
  end
end
