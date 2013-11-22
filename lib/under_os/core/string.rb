class String
  def underscore
    gsub(/([a-z\d])([A-Z]+)/, '\1_\2').gsub('-', '_').downcase
  end

  def camelize
    gsub(/(\-|_)+([a-z])?/){|m| $2 ? $2.upcase : ''}
  end

  def dasherize
    underscore.gsub('_', '-')
  end

  def capitalize
    self[0].upcase + slice(1, size)
  end

  def starts_with?(substr)
    index(substr) == 0
  end

  def ends_with?(substr)
    rindex(substr)  == size - substr.size
  end

  def blank?
    self !~ /[^[:space:]]/
  end

  def constantize
    names = self.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end
end
