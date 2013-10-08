class Scroll < UnderOs::UI::View
  wraps UIScrollView, tag: :scroll

  def initialize(options={})
    super

    self.direction = options.delete(:direction)
    self.indicator = options.delete(:indicator)
    self.bounces   = options.delete(:bounces)
    self.paging    = options.delete(:paging)
  end

  def direction
    @direction || :both
  end

  def direction=(value)
    @direction = normalize(value)

    @_.scrollEnabled = direction != :none
    @_.directionalLockEnabled = [:x, :y].include?(direction)
  end

  def indicator
    @indicator || :both
  end

  def indicator=(value)
    @indicator = normalize(value)

    @_.showsVerticalScrollIndicator   = [:both, :y].include?(indicator)
    @_.showsHorizontalScrollIndicator = [:both, :x].include?(indicator)
  end

  def bounces
    @bounces == nil ? true : @bounces
  end

  def bounces=(value)
    @bounces = value == false ? false : nil
    @_.bounces = bounces
  end

  def paging
    @paging == nil ? false : @paging
  end

  def paging=(value)
    @paging = value == true ? true : nil
    @_.pagingEnabled = paging
  end

  def contentSize
    UnderOs::UI::Size.new(x: @_.contentSize.width, y: @_.contentSize.height)
  end

  def contentSize=(*args)
    size = UnderOs::Point.new(*args)
    @_.contentSize = CGSizeMake(size.x, size.y)
  end

private

  def normalize(value)
    value = value.to_s.to_sym
    value = :y  if value == :vertical
    value = :x  if value == :horizontal
    value = nil if ![:x, :y, :none].include?(value)
    value
  end
end
