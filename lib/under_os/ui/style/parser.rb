class UnderOs::Page::StylesParser

  def parse(style)
    {}.tap do |result|
      style.scan(/(\A|\})([a-z0-9_\-\.\s#:]+)\{([^}]+)/).map do |rule|
        result[rule[1].gsub(/\s+/, ' ').strip] = parse_styles(rule[2])
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
    value = value.to_f if value =~ /^[\d\.]+$/

    if key == :background && value =~ /^[\S]+$/
      key = :backgroundColor
    end


    {key => value}
  end

end
