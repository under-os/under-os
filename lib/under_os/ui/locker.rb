class UnderOs::UI::Locker < UnderOs::UI::View
  wraps UIView, tag: :locker

  attr_reader :label, :sinner

  def initialize(options={})
    super options

    @dialog  = UnderOs::UI::View.new(class: 'locker-dialog')
    @spinner = UnderOs::UI::Spinner.new
    @label   = UnderOs::UI::Label.new(text: options[:text] || '')

    append @dialog.append(@spinner, @label)

    addClass 'with-label' if options[:text]
  end

  def show
    insertTo(UnderOs::App.history.current_page.view) if ! parent
    repaint
  end

  def hide
    remove
  end

  def text
    @label.text
  end

  def text=(text)
    @label.text = text
  end

  def show_for(&block)
    show
    UnderOs::Timer.new 0.001 do
      block.call
      UnderOs::Timer.new(0.001) { hide }
    end
  end
end
