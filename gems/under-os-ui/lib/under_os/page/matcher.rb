class UnderOs::Page::StylesMatcher

  def self.new(css_rule)
    @cache           ||= {}
    @cache[css_rule] ||= super
  end

  def initialize(css_rule)
    css_rules = css_rule.strip.split(/\s*,\s*/)

    if css_rules.size == 1
      rules    = css_rules[0].scan(/([\S]+)/).map(&:first)
      @rule    = parse(rules.pop)
      @parent  = rules.size == 0 ? false : self.class.new(rules.join(' '))
    else
      @multiple_matchers = css_rules.map{ |rule| self.class.new(rule) }
    end
  end

  def match(view)
    score_for(view) != 0
  end

  def score_for(view)
    return summary_score_for(view) if @multiple_matchers

    id_score    = id_score_for(view)
    tag_score   = tag_score_for(view)
    class_score = class_score_for(view)
    attrs_score = attrs_score_for(view)
    total_score = id_score + tag_score + class_score + attrs_score

    total_score = 0 if id_score    == 0 && @rule[:id]
    total_score = 0 if tag_score   == 0 && @rule[:tag]
    total_score = 0 if class_score == 0 && @rule[:classes].size != 0
    total_score = 0 if attrs_score == 0 && @rule[:attrs].size != 0

    if @parent && total_score != 0
      parent_score = parent_score_for(view)
      total_score  = parent_score == 0 ? 0 : total_score + parent_score
    end

    total_score
  end

private

  def summary_score_for(view)
    @multiple_matchers.map{ |matcher| matcher.score_for(view) }.max
  end

  def id_score_for(view)
    @rule[:id] == view.id ? 1 : 0
  end

  def tag_score_for(view)
    @rule[:tag] == '*' || @rule[:tag] == view.tagName ? 1 : 0
  end

  def class_score_for(view)
    return 0 if @rule[:classes].size == 0
    match = @rule[:classes] & view.classNames
    match.size == @rule[:classes].size ? match.size : 0
  end

  def attrs_score_for(view)
    score = 0; return 0 if @rule[:attrs].size == 0

    @rule[:attrs].each do |key, value, operand|
      attr = view.respond_to?(key) && view.__send__(key)
      attr = attr.to_s if attr.is_a?(Symbol) || attr.is_a?(Numeric)

      if attr && attr.is_a?(String)
        matches = case operand
        when '='  then attr == value
        when '*=' then attr.include?(value)
        when '^=' then attr.starts_with?(value)
        when '$=' then attr.ends_with?(value)
        when '~=' then attr.split(' ').include?(value)
        when '|=' then attr.split('-').include?(value)
        end

        score += 1 if matches
      end
    end

    score
  end

  def parent_score_for(view)
    parent = view; score = 0

    while parent = parent.parent
      score = @parent.score_for(parent)
      break if score > 0
    end

    score
  end

  def parse(string)
    {}.tap do |rule|
      if m = string.match(/^([a-z\*]+)/)
        rule[:tag] = m[1].upcase
      else
        rule[:tag] = false # so it wouldn't match nil
      end

      if m = string.match(/#([a-z_\-0-9]+)/)
        rule[:id] = m[1]
      else
        rule[:id] = false # so it wouldn't match nil
      end

      if m = string.scan(/(\.)([a-z_\-0-9]+)/)
        rule[:classes] = m.map{|c| c[1]}
      else
        rule[:classes] = []
      end

      if m = string.scan(/\[\s*([a-z]+)\s*([*^$~|]{0,1}=)\s*('|")?(.+?)(\3)?\s*\]/)
        rule[:attrs] = m.map{|c| [c[0], c[3], c[1]] }
      else
        rule[:attrs] = []
      end
    end
  end
end
