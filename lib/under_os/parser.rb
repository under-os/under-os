#
# Generic templates/stylesheets parsing engine
#
class UnderOs::Parser
  def self.parse(*args)
    @inst ||= new
    @inst.parse *args
  end

  def initialize
    @css  = CSS.new
    @html = HTML.new
  end

  def parse(filename)
    filepath = NSBundle.mainBundle.pathForResource(filename, ofType:nil)
    content  = UnderOs::File.read(filepath) rescue ''

    case filename.split('.').pop
    when 'css'  then @css.parse(content)
    when 'html' then @html.parse(content)
    end
  end
end
