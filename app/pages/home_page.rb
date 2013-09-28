class HomePage < UnderOs::Page

  def initialize
    self.title = 'Hello World!'

    insert Button.new(text: 'Various Stuff', style: {top: 100, left: 100})
      .on(:tap){ show_stuff }
  end

  def show_stuff
    navigation.push StuffPage.new
  end
end
