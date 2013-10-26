class LockersPage < UnderOs::Page
  def initialize
    first('#buttons #b1').on(:tap){ show_simple_locker }
    first('#buttons #b2').on(:tap){ show_locker_with_label }
  end

  def show_simple_locker
    @locker = Locker.new.show
    UnderOs::Timer.new(2) { @locker.hide }
  end

  def show_locker_with_label
    @locker = Locker.new(text: "Wait...").show
    UnderOs::Timer.new(2) { @locker.hide }
  end
end
