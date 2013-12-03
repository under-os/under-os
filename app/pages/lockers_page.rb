class LockersPage < UnderOs::Page
  def initialize
    first('#buttons #b1').on(:tap){ show_simple_locker }
    first('#buttons #b2').on(:tap){ show_locker_with_label }
  end

  def show_simple_locker
    @locker = Locker.new.show
    2.seconds.later { @locker.hide }
  end

  def show_locker_with_label
    @locker = Locker.new(text: "Wait...").show
    2.seconds.later { @locker.hide }
  end
end
