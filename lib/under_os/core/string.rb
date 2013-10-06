class String
  def underscore
    gsub(/([a-z\d])([A-Z]+)/, '\1_\2').gsub('-', '_').downcase
  end

  def camelize
    gsub(/(\-|_)+(.)?/){|m| $2 ? $2.upcase : ''}
  end

  def dasherize
    underscore.gsub('_', '-')
  end

  def starts_with?(substr)
    index(substr) == 0
  end

  def ends_with?(substr)
    size - rindex(substr) == substr.size
  end

  def blank?
    self =~ /^\s*$/
  end
end
