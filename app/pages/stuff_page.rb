class StuffPage < UnderOs::Page
  def initialize
    self.title = "Various Stuff"

    @box = View.new(style: {
      top:          50,
      left:         50,
      width:        100,
      height:       100,
      background:   :red,
      borderRadius: 10,
      borderWidth:  2,
      borderColor:  :green
    })

    @box.on(:tap){ fade_out.fade_in }

    @b2 = View.new(style: {background: :blue})
    @b2.size = {x: 50, y: 50}
    @b2.position = {x: 25, y: 25}

    @b2.on(:tap){ highlight }

    insert @box.insert(@b2)

    insert Button.new(title: 'Boo Hoo!').position(x: 100, y: 200)

    insert Label.new(text: "Hey Label", style: {background: :red}).position({x: 100, y: 250})

    insert Icon.new(:cog).position(x: 50, y: 300)
    insert Icon.new(:trash).position(x: 100, y: 300)
    insert Icon.new(:home).position(x: 150, y: 300)
    insert Icon.new(:magic).position(x: 200, y: 300)
  end
end
