class HomePage < UnderOs::Page

  def initialize
    self.title = 'Hello World!'

    insert b1 = Button.new(text: 'Various Stuff').position(x: 100, y: 100)
    insert b2 = Button.new(text: 'Caluclator Demo').position(x: 100, y: 150)

    b1.on(:tap){ navigation.push StuffPage.new      }
    b2.on(:tap){ navigation.push CalculatorPage.new }
  end
end
