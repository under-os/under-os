class HomePage < UnderOs::Page

  def initialize
    insert Label.new(text: 'Hello World!')
  end

end
