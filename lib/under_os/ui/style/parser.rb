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
        value = param[1].strip.gsub(/px$/, '')
        value = value.to_f if value =~ /^[\d\.]+$/

        hash[param[0].camelize.to_sym] = value
      end
    end
  end

end
