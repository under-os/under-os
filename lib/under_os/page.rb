#
# UOS::Page is kind of a wrap over an iOS controller
# but instead of the controller, it presents more the
# main (root) view of the controller in a sence you've
# got for DOM documents in web
#
class UnderOs::Page
  include UnderOs::Events
  include UnderOs::UI

  attr_reader :_, :stylesheet

  def self.new(*args)
    alloc.setup_wrap(*args)
  end

  def self.layout(name=nil)
    name ? (@layout = name) : @layout
  end

  def initialize
    # page building goes in here
  end

  def view
    @_view
  end

  def view=(view)
    @_view = view
  end

  %w[insert append prepend find first].each do |method|
    define_method method do |*args|
      @_view.__send__ method, *args
    end
  end

  def alert(*args)
    Alert.new(*args)
  end

  def history
    UnderOs::App.history
  end

  def navbar
    history.navbar
  end

  def title
    @_.navigationItem.title
  end

  def title=(text)
    @_.navigationItem.title = text
  end

  def name
    self.class.name.underscore.sub(/_page$/, '')
  end

  def setup_wrap(*args)
    @_ = UIViewControllerWrap.alloc.init(self, {
      on_load_view:      Proc.new{ emit('init')      },
      on_view_loaded:    Proc.new{ emit('load')      },
      on_view_appear:    Proc.new{ emit('appear')    },
      on_view_disappear: Proc.new{ emit('disappear') },
      on_view_rerender:  Proc.new{ emit('rerender')  },
      on_view_rotate:    Proc.new{ emit('rotate')    }
    })

    on 'init' do
      build_layout
      compile_styles
    end

    on 'load' do
      repaint
      initialize(*args)
      repaint
    end

    on 'rotate' do
      repaint
    end

    self
  end

  def build_layout
    @_layout = Layout.new(self)
  end

  def compile_styles
    @stylesheet = Stylesheet.new
    @stylesheet << UnderOs::App.stylesheet
    @stylesheet.load("#{name}.css")
  end

  def repaint
    view.repaint(stylesheet)   if view
    navbar.repaint(stylesheet) if navbar
  end

  #
  # A simple wrap over UIViewController to intercept
  # the iOS events
  #
  class UIViewControllerWrap < UIViewController
    attr_reader :wrapper

    def init(wrapper, options)
      @wrapper = wrapper
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

    def viewWillLayoutSubviews
      super
      @options[:on_view_rerender].call
    end

    def didRotateFromInterfaceOrientation(orientation)
      super
      @options[:on_view_rotate].call
    end

    def prefersStatusBarHidden
      !UnderOs::App.config.status_bar
    end

    def touchesBegan(touches, withEvent:event)
      UnderOs::UI::Events::TouchListeners.notify :touchstart, event
    end

    def touchesMoved(touches, withEvent:event)
      UnderOs::UI::Events::TouchListeners.notify :touchmove, event
    end

    def touchesEnded(touches, withEvent: event)
      UnderOs::UI::Events::TouchListeners.notify :touchend, event
    end

    def touchesCancelled(touches, withEvent: event)
      UnderOs::UI::Events::TouchListeners.notify :touchcancel, event
    end
  end
end
