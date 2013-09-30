#
# Generic templates/stylesheets parsing engine
#
class UnderOs::Parser
  def self.parse(*args)
    @inst ||= new
    @inst.parse *args
  end

  def parse(filename)
    if content = read("#{filename}.erb")
      content = @erb.parse(content)
    else
      content = read(filename)
    end

    if filename.ends_with?('.css')
      CSS.new.parse(content || '')
    elsif filename.ends_with?('.html')
      @html.parse(content)
    end
  end

  def read(filename)
    filename, type = filename.match(/^(.+?)\.([a-z]+)$/).to_a.slice(1,2)
    filename = NSBundle.mainBundle.pathForResource(filename, ofType:type)

    NSString.stringWithContentsOfFile(filename, encoding:NSUTF8StringEncoding, error:nil)
  end
end
