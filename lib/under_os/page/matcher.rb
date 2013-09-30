class UnderOs::Page::StylesMatcher

  def self.new(css_rule)
    @cache           ||= {}
    @cache[css_rule] ||= super
  end

  def initialize(css_rule)
    css_rule = css_rule.strip
    rules    = css_rule.scan(/([\S]+)/).map(&:first)
    @rule    = parse(rules.pop)
    @parent  = rules.size == 0 ? false : self.class.new(rules.join(' '))
  end

  def match(view)
    score_for(view) != 0
  end

  def score_for(view)
    id_score    = id_score_for(view)
    tag_score   = tag_score_for(view)
    class_score = class_score_for(view)

    return 0 if @rule[:id]  && id_score     == 0
    return 0 if @rule[:tag] && tag_score    == 0
    return 0 if @rule[:classes].size > 0 && class_score == 0
    return 0 if (this_score = id_score + tag_score + class_score) == 0

    parent_score = parent_score_for(view)

    return 0 if @parent && parent_score == 0

    parent_score + this_score
  end

private

  def id_score_for(view)
    @rule[:id] == view.id ? 1 : 0
  end

  def tag_score_for(view)
    @rule[:tag] == view.tagName ? 1 : 0
  end

  def class_score_for(view)
    match = @rule[:classes] & view.classNames
    match.size == @rule[:classes].size ? match.size : 0
  end

  def parent_score_for(view)
    return 0 if ! @parent

    parent = view; score = 0

    while parent = parent.parent
      score = @parent.score_for(parent)
      break if score > 0
    end

    score
  end

  def parse(string)
    {}.tap do |rule|
      if m = string.match(/^([a-z]+)/)
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
      end
    end
  end
end
