class UnderOs::Color
  attr_accessor :ui

  CACHE = {}

  def self.new(*args)
    color = Converter.ui_color_from(*args)
    CACHE[color] ||= super(color)
  end

  def initialize(ui_color)
    @ui = ui_color
  end

  def cg
    @ui.CGColor
  end

  def ci
    @ui.CIColor
  end

  def invert
    self.class.new to_rgba.tap do |rgba|
      rgba[0] = 255 - rgba[0]
      rgba[1] = 255 - rgba[1]
      rgba[2] = 255 - rgba[2]
    end
  end

  def to_rgba
    r = Pointer.new(:float)
    g = Pointer.new(:float)
    b = Pointer.new(:float)
    a = Pointer.new(:float)

    @ui.getRed(r, green:g, blue:b, alpha:a)

    r = (255 * r[0]).round
    g = (255 * g[0]).round
    b = (255 * b[0]).round

    [r,g,b,a[0]]
  end

  def to_rgb
    to_rgba.slice(0, 3)
  end

  def to_hex
    r, g, b = to_rgb
    int = (r << 16) + (g << 8) + b
    '#' + int.to_s(16).rjust(6, '0')
  end

  def to_s
    to_hex
  end

  def ==(color)
    color = if color.is_a?(self.class)
      color
    else
      color = [color] if ! color.is_a?(Array)
      self.class.new(*color)
    end

    to_s == color.to_s
  end

  module Converter
    extend self

    def ui_color_from(*args)
      origin = args.size == 1 ? args[0] : args

      if    origin.is_a?(UIColor) then origin
      elsif origin.is_a?(Array)   then color_from_array(*origin)
      elsif origin.is_a?(String)  then color_from_string(origin)
      elsif origin.is_a?(Symbol)  then color_from_string(origin.to_s)
      elsif origin.is_a?(Float)   then color_from_param(origin)
      elsif origin.is_a?(Integer) then color_from_param(origin / 100.0)
      else                             UIColor.redColor # fallback
      end
    end

    def color_from_array(r,g,b,a=1.0)
      r = r / 255.0 if r.is_a?(Integer) || r > 1.0
      g = g / 255.0 if g.is_a?(Integer) || g > 1.0
      b = b / 255.0 if b.is_a?(Integer) || b > 1.0

      UIColor.colorWithRed(r, green: g, blue: b, alpha: a)
    end

    def color_from_string(name)
      name = name.downcase.strip
      name = 'clear'     if name == 'transparent'
      name = 'darkGray'  if name == 'darkgray'
      name = 'lightGray' if name == 'lightgray'

      return UIColor.send("#{name}Color") if IOS_COLORS.include?(name)

      name = HTML_COLORS[name] || name
      name = "#" + name[1]*2 + name[2]*2 + name[3]*2 if name =~ /^#[abcdef0-9]{3}$/

      r, g, b, a = if name =~ /^#[abcdef0-9]{6}$/
        hex_2_rgb(name)
      elsif m = name.match(/^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d*)\s*\)$/)
        [m[1].to_i, m[2].to_i, m[3].to_i]
      elsif m = name.match(/^rgba\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d*)\s*,\s*([\d\.]+)\s*\)$/)
        [m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_f]
      else
        raise "Malformed color spec: #{name.inspect}"
      end

      color_from_array(r, g, b, a || 1.0)
    end

    def color_from_param(param) # 0.0..1.0
      color_from_array *param_2_rgb(param)
    end

    def hex_2_rgb(hex)
      int = hex[1..-1].to_i(16)

      r   = (int & 0xFF0000) >> 16
      g   = (int & 0xFF00)   >> 8
      b   = (int & 0xFF)

      [r, g, b]
    end

    def param_2_rgb(a) # 0.0..1.0
      x = 1 / 6.0
      s = a % x / x
      r = 1 - s

      if    a < x     then [1.0, s,   0.0]
      elsif a < x * 2 then [r,   1.0, 0.0]
      elsif a < x * 3 then [0.0, 1.0, s]
      elsif a < x * 4 then [0.0, r,   1.0]
      elsif a < x * 5 then [s,   0.0, 1.0]
      else                 [1.0, 0.0, r]
      end
    end

    IOS_COLORS = %w[
      black
      darkGray
      lightGray
      white
      gray
      red
      green
      blue
      cyan
      yellow
      magenta
      orange
      purple
      brown
      clear
    ].freeze

    HTML_COLORS = {
      maroon:  '#800000',
      olive:   '#808000',
      fuchsia: '#ff00ff',
      lime:    '#00ff00',
      navy:    '#000080',
      aqua:    '#00ffff',
      teal:    '#008080',
      silver:  '#c0c0c0',
    }.freeze
  end
end
