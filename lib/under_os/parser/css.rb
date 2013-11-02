class UnderOs::Parser::CSS
  def parse(style)
    style = style.gsub(/\/\*[\s\S]+?\*\//, '').strip

    {}.tap do |result|
      style.scan(/(\A|\})([a-z0-9_\-\.\s#:,]+)\{([^}]+)/).map do |rule|
        values = parse_styles(rule[2])

        rule[1].split(',').each do |css_rule|
          result[css_rule.gsub(/\s+/, ' ').strip] = values
        end
      end
    end
  end

  def parse_styles(styles)
    {}.tap do |hash|
      styles.scan(/([a-z\-]+)\s*:\s*([^;]+)\s*/).each do |param|
        hash.merge! normalized_values(param[0], param[1])
      end
    end
  end

  def normalized_values(key, value)
    key   = key.camelize.to_sym
    value = value.strip.gsub(/px$/, '')
    value = value.gsub(/^('|")(.*?)\1$/, '\2')
    value = value.to_f if value =~ /^[\-\d\.]+$/

    if key == :background && value =~ /^[\S]+$/
      key = :backgroundColor
    end


    {key => value}
  end
end
