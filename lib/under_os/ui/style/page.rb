#
# Represents a page's compund styles
#
# Basically it reads/parses the page's related stylesheets
# and creates a compound style definitions registry for it
# so that we could throw in any element and get it painted
# accordingly
#
class UnderOs::Page::Styles

  def initialize(page)
    @page = page

    parse stylesheet
  end

  def stylesheet
    filename = @page.class.name.underscore
    filename = filename.gsub(/_page$/, '')
    filename = NSBundle.mainBundle.pathForResource(filename, ofType:"css")

    NSData.dataWithContentsOfFile(filename)
  end

  def parse(styles)
    p styles
  end
end
