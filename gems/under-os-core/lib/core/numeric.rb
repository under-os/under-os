class Numeric
  def milliseconds
    UnderOs::Timer::Duration.new(self.to_f / 1000)
  end

  alias :ms :milliseconds

  def seconds
    UnderOs::Timer::Duration.new(self)
  end

  def minutes
    UnderOs::Timer::Duration.new(self * 60)
  end

  def hours
    UnderOs::Timer::Duration.new(self * 3600)
  end

  def days
    UnderOs::Timer::Duration.new(self * 86400)
  end
end
