class UnderOs::Page::StylesParser

  def initialize(type)
    @type = type
  end

  def parse(style)
    style.scan(/(\A|\})([a-z0-9_\-\.\s#:]+)\{([^}]+)/).map do |rule|
      {rules: parse_rules(rule[1]), styles: parse_styles(rule[2])}
    end
  end

  def parse_rules(rules)
    rules.scan(/([\S]+)/).map{|r| parse_rule(r[0]) }
  end

  def parse_rule(string)
    {}.tap do |rule|
      if m = string.match(/^([a-z]+)/)
        rule[:tag] = m[1]
      end

      if m = string.match(/#([a-z_\-0-9]+)/)
        rule[:id] = m[1]
      end

      if m = string.scan(/(\.)([a-z_\-0-9]+)/)
        rule[:class] = m.map{|c| c[1]} if m.size != 0
      end

      if string.match(/:vertical/)
        rule[:vertical] = true
      end

      if string.match(/:horizontal/)
        rule[:horizontal] = true
      end
    end
  end

  def parse_styles(styles)
    {}.tap do |hash|
      styles.scan(/([a-z\-]+)\s*:\s*([^;]+)\s*/).each do |param|
        value = param[1].strip.gsub(/px$/, '')
        value = value.to_f if value =~ /^[\d\.]+$/

        hash[param[0]] = value
      end
    end
  end

end
