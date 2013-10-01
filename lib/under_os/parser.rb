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
    content = read(filename) || ''

    case filename.split('.').pop
    when 'css'  then @css.parse(content)
    when 'html' then @html.parse(content)
    end
  end

  def read(filename)
    filename, type = filename.match(/^(.+?)\.([a-z]+)$/).to_a.slice(1,2)
    filename = NSBundle.mainBundle.pathForResource(filename, ofType:type)

    NSString.stringWithContentsOfFile(filename, encoding:NSUTF8StringEncoding, error:nil)
  end
end
