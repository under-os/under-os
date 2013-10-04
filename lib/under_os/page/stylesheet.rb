class UnderOs::Page::Stylesheet
  attr_reader :rules

  def initialize(styles={})
    @rules = {}

    styles.each do |rule, style|
      self[rule] = style
    end
  end

  def apply_to(view)
    view.style = styles_for(view)
  end

  def styles_for(view)
    {}.tap do |styles|
      weighted_styles_for(view).each do |hash|
        hash.each do |key, value|
          styles[key] = value
        end
      end
    end
  end

  def [](rule)
    @rules[rule.to_s]
  end

  def []=(rule, values)
    @rules[rule.to_s] ||= {}
    @rules[rule.to_s].merge! values
  end

  def <<(another_stylesheet)
    another_stylesheet.rules.each do |rule, styles|
      self[rule] = styles
    end
  end

  def +(another_stylesheet)
    self.class.new.tap do |combined_sheet|
      combined_sheet << self
      combined_sheet << another_stylesheet
    end
  end

  def load(filename)
    UnderOs::Parser.parse(filename).each do |rule, styles|
      self[rule] = styles
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
      @rules.each do |css, rule|
        score = UnderOs::Page::StylesMatcher.new(css).score_for(view)
        styles << {score: score, style: rule} if score != 0
      end
    end
  end

end
