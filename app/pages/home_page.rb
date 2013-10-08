class HomePage < UnderOs::Page

  def initialize
    self.title = 'Home'

    insert b1 = Button.new(text: 'Various Stuff').position(y: 100)
    insert b2 = Button.new(text: 'Caluclator Demo').position(y: 150)
    insert b3 = Button.new(text: 'Inputs Demo').position(y: 200)
    insert b4 = Button.new(text: 'Sidebars Demo').position(y: 250)
    insert b5 = Button.new(text: 'Scrolls Demo').position(y: 300)

    b1.on(:tap){ navigation.push StuffPage.new      }
    b2.on(:tap){ navigation.push CalculatorPage.new }
    b3.on(:tap){ navigation.push InputsPage.new     }
    b4.on(:tap){ navigation.push SidebarsPage.new   }
    b5.on(:tap){ navigation.push ScrollsPage.new    }
  end
end
