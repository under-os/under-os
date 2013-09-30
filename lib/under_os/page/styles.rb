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
    @rules = {
      app:  UnderOs::Parser.parse("application.css"),
      page: UnderOs::Parser.parse("#{page.name}.css")
    }
  end

  def apply_to(view)
    view.style = calculate_for(view)
  end

  def calculate_for(view)
    {}.tap do |styles|
      weighted_styles_for(view).each do |hash|
        hash.each do |key, value|
          styles[key] = value
        end
      end
    end
  end


private

  def weighted_styles_for(view)
    find_styles_for(view).
      sort{|a,b| a[:score] <=> b[:score]}.
      map{|e| e[:style]}
  end

  def find_styles_for(view)
    [].tap do |styles|
      [:app, :page].each do |source|
        @rules[source].each do |css, rule|
          score = UnderOs::Page::StylesMatcher.new(css).score_for(view)
          styles << {score: score, style: rule} if score != 0
        end
      end
    end
  end

end
