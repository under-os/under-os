class UnderOs::UI::Label < UnderOs::UI::View

  def initialize(options={}, raw_object=UILabel)
    super

    options = {} if ! options.is_a?(Hash)

    self.text = options.delete(:text) || ''
    @_.sizeToFit

    @_.numberOfLines             = 1;
    @_.adjustsFontSizeToFitWidth = true;
  end

  def text
    @_.text
  end

  def text=(text)
    @_.text = text
  end
end
