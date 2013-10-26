class UnderOs::UI::Spinner < UnderOs::UI::View
  wraps UIActivityIndicatorView, tag: :spinner

  def initialize(options={})
    super
    show
  end

  def show
    @_.startAnimating
    self
  end

  def hide
    @_.stopAnimating
    self
  end

  def hidden
    @_.isAnimating == 0
  end

end
