class HomePage < UnderOs::Page

  def initialize
    self.title = 'Home'

    insert b1 = Button.new(text: 'Various Stuff').position(x: 100, y: 100)
    insert b2 = Button.new(text: 'Caluclator Demo').position(x: 100, y: 150)
    insert b3 = Button.new(text: 'Inputs Demo').position(x: 100, y: 200)

    b1.on(:tap){ navigation.push StuffPage.new      }
    b2.on(:tap){ navigation.push CalculatorPage.new }
    b3.on(:tap){ navigation.push InputsPage.new     }
  end
end
