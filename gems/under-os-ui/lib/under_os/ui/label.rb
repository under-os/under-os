class UnderOs::UI::Label < UnderOs::UI::View
  wraps UILabel, tag: 'label'

  def initialize(options={})
    super

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
