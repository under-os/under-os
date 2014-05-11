class UnderOs::UI::Alert
  include UnderOs::Event::Listener

  def initialize(options={})
    options = {message: options}  if options.is_a?(String)
    self.on = options.delete[:on] if options[:on]

    @_ = CustomAlertView.alloc.initiWithOptions(self, options)
    @_.show unless options[:show] == false
  end

  def show
    @_.show
    self
  end

  def hide(animated=true)
    @_.dismissWithClickedButtonIndex(0, animated: animated)
    self
  end

  def visible
    @_.visible
  end

  def hidden
    !visible
  end

  class CustomAlertView < UIAlertView
    def initiWithOptions(wrapper, options)
      @wrapper = wrapper

      initWithTitle(     options[:title]   || "",
                message: options[:message] || "No message given",
               delegate: self,
      cancelButtonTitle: options[:button]  || "Ok",
      otherButtonTitles: nil )

      (options[:buttons] || []).each do |title|
        addButtonWithTitle title
      end

      self
    end

    def alertView(alertView, willDismissWithButtonIndex:buttonIndex)
      @wrapper.emit(:tap, buttonIndex: buttonIndex, buttonTitle: buttonTitleAtIndex(buttonIndex))
      @wrapper.emit(:close)
    end
  end
end
