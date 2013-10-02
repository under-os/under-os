#
# UOS::Page is kind of a wrap over an iOS controller
# but instead of the controller, it presents more the
# main (root) view of the controller in a sence you've
# got for DOM documents in web
#
class UnderOs::Page
  include UnderOs::Events
  include UnderOs::UI

  attr_reader :_

  def self.new(*args)
    alloc.setup_wrap
  end

  def self.navigation=(navigation)
    @navigation = navigation
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

  def navigation
    UnderOs::Page.instance_variable_get('@navigation')
  end

  def title
    navigation && @_.navigationItem.title
  end

  def title=(text)
    @_.navigationItem.title = text if navigation
  end

  def name
    self.class.name.underscore.sub(/_page$/, '')
  end

  def setup_wrap
    @_ = UIViewControllerWrap.alloc.init({
      on_load_view:      Proc.new{ emit('init')      },
      on_view_loaded:    Proc.new{ emit('load')      },
      on_view_appear:    Proc.new{ emit('appear')    },
      on_view_disappear: Proc.new{ emit('disappear') }
    })

    on 'init' do
      build_layout
      compile_styles
    end

    on 'load' do
      initialize
      apply_styles_to(view)
    end

    self
  end

  def build_layout
    @_layout = Layout.new(self)
  end

  def compile_styles
    @compound_styles = Styles.new(self)
  end

  def apply_styles_to(view)
    @compound_styles.apply_to(view)

    view.children.each do |subview|
      apply_styles_to(subview)
    end
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
