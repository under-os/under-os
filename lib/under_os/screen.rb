class Screen
  def self.size
    # TODO make it handle the screen orientation
    UOS::Point.new({
      x: UIScreen.mainScreen.bounds.size.width,
      y: UIScreen.mainScreen.bounds.size.height
    })
  end
end
