#
# UOS::Page is kind of a wrap over an iOS controller
# but instead of the controller, it presents more the
# main (root) view of the controller in a sence you've
# got for DOM documents in web
#
class UnderOs::Page
  include UnderOs::Events
  include UnderOs::UI

  def self.new(*args)
    alloc.setup_wrap
  end

  def initialize
    # page building goes in here
  end

  def insert(*args)
    @view.insert(*args)
  end

  def append(*args)
    @view.insert(*args)
  end

  def prepend(*args)
    @view.insert(*args)
  end

  def setup_wrap
    @_ = UIViewControllerWrap.alloc.init({
      on_load_view:      Proc.new{ emit('init')      },
      on_view_loaded:    Proc.new{ emit('load')      },
      on_view_appear:    Proc.new{ emit('appear')    },
      on_view_disappear: Proc.new{ emit('disappear') }
    })

    on 'load' do
      @view = View.new(@_.view)
      initialize
    end

    self
  end

  #
  # A simple wrap over UIViewController to intercept
  # the iOS events
  #
  class UIViewControllerWrap < UIViewController

    def init(options)
      @options = options
      initWithNibName(nil, bundle: nil)
    end

    def loadView
      super
      @options[:on_load_view].call
    end

    def viewDidLoad
      super
      @options[:on_view_loaded].call
    end

    def viewDidAppear(animated)
      super
      @options[:on_view_appear].call
    end

    def viewDidDisappear(animated)
      super
      @options[:on_view_disappear].call
    end

  end
end
