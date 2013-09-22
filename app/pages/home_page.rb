class HomePage < UnderOs::Page

  def initialize
    self.title = 'Hello World!'

    insert Label.new(text: 'Hello World!', style: {top: 100, left: 50})
  end

end
